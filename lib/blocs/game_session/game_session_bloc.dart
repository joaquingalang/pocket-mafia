import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/enums/team_victory.dart';
import 'package:pocket_mafia/enums/vote_result.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  GameSessionBloc() : super(const GameSessionState()) {
    on<GameSetPhaseDurations>(_onSetPhaseDurations);
    on<GameSetPhase>(_onSetPhase);
    on<GameAssignRoles>(_onAssignRoles);
    on<GameBuildVoteMap>(_onBuildVoteMap);
    on<GamePlayerVote>(_onPlayerVote);
    on<GameTallyVotes>(_onTallyVotes);
    on<GameMafiaKill>(_onMafiaKill);
    on<GameDetectiveInvestigate>(_onDetectiveInvestigate);
    on<GameDoctorHeal>(_onDoctorHeal);
    on<GameVigilanteKill>(_onVigilanteKill);
    on<GameResolveNight>(_onResolveNight);
    on<GameMediumRevive>(_onMediumRevive);
    on<GamePreacherGuess>(_onPreacherGuess);
    on<GameMafiaWin>(_onMafiaWin);
    on<GameVillageWin>(_onVillageWin);
    on<GameJesterWin>(_onJesterWin);
    on<GameHeadhunterWin>(_onHeadhunterWin);
    on<GameReset>(_onGameReset);
  }

  void _onSetPhaseDurations(
    GameSetPhaseDurations event,
    Emitter<GameSessionState> emit,
  ) {
    emit(
      state.copyWith(
        dayDuration: event.dayDuration,
        voteDuration: event.voteDuration,
        nightDuration: event.nightDuration,
      ),
    );
  }

  void _onSetPhase(GameSetPhase event, Emitter<GameSessionState> emit) {
    if (event.phase == Phase.day && state.phase == Phase.nightResult) {
      emit(state.copyWith(
        phase: Phase.day,
        round: state.round + 1,
        mafiaKillTarget: null,
        vigilanteKillTarget: null,
        snitchSuspects: [],
      ));
    } else {
      emit(state.copyWith(phase: event.phase));
    }
  }

  void _onAssignRoles(GameAssignRoles event, Emitter<GameSessionState> emit) {
    List<Roles> roles = List.from(event.roles);

    if (roles.length > event.names.length) {
      roles = roles.sublist(0, event.names.length);
    }

    final deficit = event.names.length - roles.length;
    for (int i = 0; i < deficit; i++) {
      roles.add(Roles.villager);
    }

    roles.shuffle();

    List<Player> players = List.generate(event.names.length, (i) {
      return Player(name: event.names[i], role: Role.initFields(roles[i]));
    });

    // Pair up Lovers
    final loverIndices = players.indexWhere((p) => p.role.type == Roles.lover);
    if (loverIndices != -1) {
      final allLoverIndices = <int>[];
      for (int i = 0; i < players.length; i++) {
        if (players[i].role.type == Roles.lover) allLoverIndices.add(i);
      }
      // Pair them in sequential pairs
      for (int i = 0; i + 1 < allLoverIndices.length; i += 2) {
        final a = allLoverIndices[i];
        final b = allLoverIndices[i + 1];
        players[a] = players[a].copyWith(loverPartner: players[b].name);
        players[b] = players[b].copyWith(loverPartner: players[a].name);
      }
    }

    // Assign Headhunter target
    Player? headhunterTarget;
    final headhunterIndex = players.indexWhere((p) => p.role.type == Roles.headhunter);
    if (headhunterIndex != -1) {
      final nonHeadhunters = players.where((p) => p.role.type != Roles.headhunter).toList();
      if (nonHeadhunters.isNotEmpty) {
        headhunterTarget = nonHeadhunters[Random().nextInt(nonHeadhunters.length)];
      }
    }

    emit(state.copyWith(
      players: players,
      headhunterTarget: headhunterTarget,
    ));
  }

  void _onBuildVoteMap(
    GameBuildVoteMap event,
    Emitter<GameSessionState> emit,
  ) {
    emit(state.copyWith(
      voteMap: {for (var player in state.players.where((p) => !p.isDeceased)) player: 0},
    ));
  }

  void _onPlayerVote(GamePlayerVote event, Emitter<GameSessionState> emit) {
    final voteWeight = switch (event.voter.role.type) {
      Roles.celebrity => 2,
      Roles.preacher => state.preacherVoteBonus,
      _ => 1,
    };
    final updatedMap = Map<Player, int>.from(state.voteMap);
    updatedMap[event.target] = (updatedMap[event.target] ?? 0) + voteWeight;
    emit(state.copyWith(voteMap: updatedMap));
  }

  void _onTallyVotes(GameTallyVotes event, Emitter<GameSessionState> emit) {
    if (state.voteMap.isEmpty) {
      emit(state.copyWith(
        voteResult: VoteResult.spared,
        eliminatedPlayer: null,
        phase: Phase.voteResult,
      ));
      return;
    }

    final maxVotes = state.voteMap.values.reduce((a, b) => a > b ? a : b);
    final topEntries = state.voteMap.entries.where((e) => e.value == maxVotes).toList();

    if (maxVotes == 0 || topEntries.length > 1) {
      final result = maxVotes == 0 ? VoteResult.spared : VoteResult.divided;
      emit(state.copyWith(
        voteResult: result,
        eliminatedPlayer: null,
        phase: Phase.voteResult,
      ));
      return;
    }

    final eliminated = topEntries.first.key;
    final deceasedPlayer = eliminated.copyWith(isDeceased: true);
    List<Player> updatedPlayers = state.players
        .map((p) => p == eliminated ? deceasedPlayer : p)
        .toList();

    // Propagate Lover death
    if (deceasedPlayer.loverPartner != null) {
      updatedPlayers = _killLoverPartner(updatedPlayers, deceasedPlayer.loverPartner!);
    }

    // Snitch effect
    List<Player> snitchSuspects = [];
    if (eliminated.role.type == Roles.snitch) {
      snitchSuspects = _pickSnitchSuspects(updatedPlayers, eliminated);
    }

    // Special win conditions (checked before standard wins)
    if (eliminated.role.type == Roles.jester) {
      emit(state.copyWith(
        players: updatedPlayers,
        eliminatedPlayer: deceasedPlayer,
        voteResult: VoteResult.executed,
        snitchSuspects: snitchSuspects,
        winner: TeamVictory.jester,
        phase: Phase.voteResult,
      ));
      return;
    }

    if (state.headhunterTarget != null &&
        eliminated == state.headhunterTarget &&
        updatedPlayers.any((p) => p.role.type == Roles.headhunter && !p.isDeceased)) {
      emit(state.copyWith(
        players: updatedPlayers,
        eliminatedPlayer: deceasedPlayer,
        voteResult: VoteResult.executed,
        snitchSuspects: snitchSuspects,
        winner: TeamVictory.headhunter,
        phase: Phase.voteResult,
      ));
      return;
    }

    emit(state.copyWith(
      players: updatedPlayers,
      eliminatedPlayer: deceasedPlayer,
      voteResult: VoteResult.executed,
      snitchSuspects: snitchSuspects,
      phase: Phase.voteResult,
    ));

    _checkAndEmitWinner(emit);
  }

  // Sets pending mafia kill — does NOT mark player as deceased yet
  void _onMafiaKill(GameMafiaKill event, Emitter<GameSessionState> emit) {
    final target = state.players[event.index];
    emit(state.copyWith(pendingMafiaKill: target));
  }

  void _onDetectiveInvestigate(
    GameDetectiveInvestigate event,
    Emitter<GameSessionState> emit,
  ) {
    final target = state.players[event.index];
    emit(state.copyWith(investigationResult: target.role.team));
  }

  // Sets doctor protect target — resolution happens in GameResolveNight
  void _onDoctorHeal(GameDoctorHeal event, Emitter<GameSessionState> emit) {
    final target = state.players[event.index];
    emit(state.copyWith(doctorProtectTarget: target));
  }

  void _onVigilanteKill(
    GameVigilanteKill event,
    Emitter<GameSessionState> emit,
  ) {
    final target = state.players[event.index];
    final deceased = target.copyWith(isDeceased: true);
    final updatedPlayers = state.players
        .map((p) => p == target ? deceased : p)
        .toList();

    emit(state.copyWith(
      players: updatedPlayers,
      vigilanteKillTarget: deceased,
      vigilanteHasKilled: true,
    ));
  }

  void _onResolveNight(GameResolveNight event, Emitter<GameSessionState> emit) {
    List<Player> updatedPlayers = List.from(state.players);
    Player? mafiaKillResult;

    // Resolve mafia kill vs doctor protect
    if (state.pendingMafiaKill != null) {
      final saved = state.doctorProtectTarget != null &&
          state.pendingMafiaKill == state.doctorProtectTarget;
      if (!saved) {
        final target = state.pendingMafiaKill!;
        final deceased = target.copyWith(isDeceased: true);
        updatedPlayers = updatedPlayers.map((p) => p == target ? deceased : p).toList();
        mafiaKillResult = deceased;
      }
    }

    // Collect all night deaths for Lover propagation and Snitch
    final nightDeaths = <Player>[
      if (mafiaKillResult != null) mafiaKillResult,
      if (state.vigilanteKillTarget != null) state.vigilanteKillTarget!,
    ];

    // Propagate Lover deaths
    for (final dead in List.from(nightDeaths)) {
      if (dead.loverPartner != null) {
        updatedPlayers = _killLoverPartner(updatedPlayers, dead.loverPartner!);
        final partner = updatedPlayers.firstWhere(
          (p) => p.name == dead.loverPartner,
          orElse: () => dead,
        );
        if (partner != dead) nightDeaths.add(partner);
      }
    }

    // Snitch suspects
    List<Player> snitchSuspects = state.snitchSuspects;
    for (final dead in nightDeaths) {
      if (dead.role.type == Roles.snitch) {
        snitchSuspects = _pickSnitchSuspects(updatedPlayers, dead);
        break;
      }
    }

    // Preacher guess check
    int preacherBonus = state.preacherVoteBonus;
    if (state.preacherGuessTarget != null) {
      final guessedName = state.preacherGuessTarget!.name;
      if (nightDeaths.any((p) => p.name == guessedName)) {
        preacherBonus += 1;
      }
    }

    emit(state.copyWith(
      players: updatedPlayers,
      mafiaKillTarget: mafiaKillResult,
      pendingMafiaKill: null,
      doctorProtectTarget: null,
      preacherGuessTarget: null,
      preacherVoteBonus: preacherBonus,
      snitchSuspects: snitchSuspects,
      phase: Phase.nightResult,
    ));

    _checkAndEmitWinner(emit);
  }

  void _onMediumRevive(GameMediumRevive event, Emitter<GameSessionState> emit) {
    final target = state.players[event.index];
    final revived = target.copyWith(isDeceased: false);
    final updatedPlayers = state.players
        .map((p) => p == target ? revived : p)
        .toList();

    emit(state.copyWith(
      players: updatedPlayers,
      mediumHasRevived: true,
    ));
  }

  void _onPreacherGuess(GamePreacherGuess event, Emitter<GameSessionState> emit) {
    final target = state.players[event.index];
    emit(state.copyWith(preacherGuessTarget: target));
  }

  void _onMafiaWin(GameMafiaWin event, Emitter<GameSessionState> emit) {
    emit(state.copyWith(winner: TeamVictory.mafia));
  }

  void _onVillageWin(GameVillageWin event, Emitter<GameSessionState> emit) {
    emit(state.copyWith(winner: TeamVictory.village));
  }

  void _onJesterWin(GameJesterWin event, Emitter<GameSessionState> emit) {
    emit(state.copyWith(winner: TeamVictory.jester));
  }

  void _onHeadhunterWin(
    GameHeadhunterWin event,
    Emitter<GameSessionState> emit,
  ) {
    emit(state.copyWith(winner: TeamVictory.headhunter));
  }

  void _onGameReset(GameReset event, Emitter<GameSessionState> emit) {
    emit(const GameSessionState());
  }

  // --- Helpers ---

  void _checkAndEmitWinner(Emitter<GameSessionState> emit) {
    if (state.winner != null) return;
    final alive = state.players.where((p) => !p.isDeceased).toList();
    final aliveMafia = alive.where((p) => p.role.type == Roles.mafia).length;
    final aliveVillage = alive.length - aliveMafia;
    if (aliveMafia == 0) {
      emit(state.copyWith(winner: TeamVictory.village));
    } else if (aliveMafia >= aliveVillage) {
      emit(state.copyWith(winner: TeamVictory.mafia));
    }
  }

  List<Player> _killLoverPartner(List<Player> players, String partnerName) {
    return players.map((p) {
      if (p.name == partnerName && !p.isDeceased) {
        return p.copyWith(isDeceased: true);
      }
      return p;
    }).toList();
  }

  List<Player> _pickSnitchSuspects(List<Player> players, Player snitch) {
    final candidates = players
        .where((p) => p != snitch && !p.isDeceased)
        .toList()
      ..shuffle();
    return candidates.take(2).toList();
  }
}
