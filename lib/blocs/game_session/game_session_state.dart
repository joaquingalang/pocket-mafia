import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/enums/team_victory.dart';
import 'package:pocket_mafia/enums/vote_result.dart';
import 'package:pocket_mafia/models/player.dart';

class _Unset {
  const _Unset();
}

const _unset = _Unset();

class GameSessionState extends Equatable {
  const GameSessionState({
    this.players = const [],
    this.dayDuration = const Duration(seconds: 300),
    this.nightDuration = const Duration(seconds: 60),
    this.voteDuration = const Duration(seconds: 30),
    this.phase = Phase.day,
    this.round = 1,
    this.isVoting = false,
    this.voteMap = const {},
    this.snitchSuspects = const [],
    this.vigilanteHasKilled = false,
    this.mediumHasRevived = false,
    this.preacherVoteBonus = 1,
    this.eliminatedPlayer,
    this.voteResult,
    this.mafiaKillTarget,
    this.pendingMafiaKill,
    this.doctorProtectTarget,
    this.vigilanteKillTarget,
    this.investigationResult,
    this.headhunterTarget,
    this.preacherGuessTarget,
    this.winner,
  });

  final List<Player> players;
  final Duration dayDuration;
  final Duration nightDuration;
  final Duration voteDuration;
  final Phase phase;
  final int round;
  final bool isVoting;
  final Map<Player, int> voteMap;
  final List<Player> snitchSuspects;
  final bool vigilanteHasKilled;
  final bool mediumHasRevived;
  final int preacherVoteBonus;
  final Player? eliminatedPlayer;
  final VoteResult? voteResult;
  final Player? mafiaKillTarget;
  final Player? pendingMafiaKill;
  final Player? doctorProtectTarget;
  final Player? vigilanteKillTarget;
  final Teams? investigationResult;
  final Player? headhunterTarget;
  final Player? preacherGuessTarget;
  final TeamVictory? winner;

  GameSessionState copyWith({
    List<Player>? players,
    Duration? dayDuration,
    Duration? voteDuration,
    Duration? nightDuration,
    Phase? phase,
    int? round,
    bool? isVoting,
    Map<Player, int>? voteMap,
    List<Player>? snitchSuspects,
    bool? vigilanteHasKilled,
    bool? mediumHasRevived,
    int? preacherVoteBonus,
    Object? eliminatedPlayer = _unset,
    Object? voteResult = _unset,
    Object? mafiaKillTarget = _unset,
    Object? pendingMafiaKill = _unset,
    Object? doctorProtectTarget = _unset,
    Object? vigilanteKillTarget = _unset,
    Object? investigationResult = _unset,
    Object? headhunterTarget = _unset,
    Object? preacherGuessTarget = _unset,
    Object? winner = _unset,
  }) {
    return GameSessionState(
      players: players ?? this.players,
      dayDuration: dayDuration ?? this.dayDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      phase: phase ?? this.phase,
      round: round ?? this.round,
      isVoting: isVoting ?? this.isVoting,
      voteMap: voteMap ?? this.voteMap,
      snitchSuspects: snitchSuspects ?? this.snitchSuspects,
      vigilanteHasKilled: vigilanteHasKilled ?? this.vigilanteHasKilled,
      mediumHasRevived: mediumHasRevived ?? this.mediumHasRevived,
      preacherVoteBonus: preacherVoteBonus ?? this.preacherVoteBonus,
      eliminatedPlayer: eliminatedPlayer == _unset ? this.eliminatedPlayer : eliminatedPlayer as Player?,
      voteResult: voteResult == _unset ? this.voteResult : voteResult as VoteResult?,
      mafiaKillTarget: mafiaKillTarget == _unset ? this.mafiaKillTarget : mafiaKillTarget as Player?,
      pendingMafiaKill: pendingMafiaKill == _unset ? this.pendingMafiaKill : pendingMafiaKill as Player?,
      doctorProtectTarget: doctorProtectTarget == _unset ? this.doctorProtectTarget : doctorProtectTarget as Player?,
      vigilanteKillTarget: vigilanteKillTarget == _unset ? this.vigilanteKillTarget : vigilanteKillTarget as Player?,
      investigationResult: investigationResult == _unset ? this.investigationResult : investigationResult as Teams?,
      headhunterTarget: headhunterTarget == _unset ? this.headhunterTarget : headhunterTarget as Player?,
      preacherGuessTarget: preacherGuessTarget == _unset ? this.preacherGuessTarget : preacherGuessTarget as Player?,
      winner: winner == _unset ? this.winner : winner as TeamVictory?,
    );
  }

  @override
  List<Object?> get props => [
    players,
    round,
    isVoting,
    phase,
    voteMap,
    snitchSuspects,
    vigilanteHasKilled,
    mediumHasRevived,
    preacherVoteBonus,
    eliminatedPlayer,
    voteResult,
    mafiaKillTarget,
    pendingMafiaKill,
    doctorProtectTarget,
    vigilanteKillTarget,
    investigationResult,
    headhunterTarget,
    preacherGuessTarget,
    winner,
  ];
}
