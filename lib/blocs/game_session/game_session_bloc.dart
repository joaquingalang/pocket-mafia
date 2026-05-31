import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  GameSessionBloc() : super(const GameSessionState()) {
    on<GameSetPhaseDurations>(_onSetPhaseDurations);
    on<GameSetPhase>(_onSetPhase);
    on<GameAssignRoles>(_onAssignRoles);
    on<GameVillageVote>(_onVillageVote);
    on<GameMafiaKill>(_onMafiaKill);
    on<GameDetectiveInvestigate>(_onDoctorInvestigate);
    on<GameDoctorHeal>(_onDoctorHeal);
    on<GameVigilanteKill>(_onVigilanteKill);
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
    emit(state.copyWith(phase: event.phase));
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

    final players = List.generate(event.names.length, (i) {
      return Player(name: event.names[i], role: Role.initFields(roles[i]));
    });

    emit(state.copyWith(players: players));
  }

  void _onVillageVote(GameVillageVote event, Emitter<GameSessionState> emit) {}

  void _onMafiaKill(GameMafiaKill event, Emitter<GameSessionState> emit) {}

  void _onDoctorInvestigate(
    GameDetectiveInvestigate event,
    Emitter<GameSessionState> emit,
  ) {}

  void _onDoctorHeal(GameDoctorHeal event, Emitter<GameSessionState> emit) {}

  void _onVigilanteKill(
    GameVigilanteKill event,
    Emitter<GameSessionState> emit,
  ) {}

  void _onMafiaWin(GameMafiaWin event, Emitter<GameSessionState> emit) {}

  void _onVillageWin(GameVillageWin event, Emitter<GameSessionState> emit) {}

  void _onJesterWin(GameJesterWin event, Emitter<GameSessionState> emit) {}

  void _onHeadhunterWin(
    GameHeadhunterWin event,
    Emitter<GameSessionState> emit,
  ) {}

  void _onGameReset(GameReset event, Emitter<GameSessionState> emit) {}
}
