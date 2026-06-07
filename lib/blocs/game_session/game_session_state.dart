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
    this.eliminatedPlayer,
    this.voteResult,
    this.mafiaKillTarget,
    this.vigilanteKillTarget,
    this.investigationResult,
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
  final Player? eliminatedPlayer;
  final VoteResult? voteResult;
  final Player? mafiaKillTarget;
  final Player? vigilanteKillTarget;
  final Teams? investigationResult;
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
    Object? eliminatedPlayer = _unset,
    Object? voteResult = _unset,
    Object? mafiaKillTarget = _unset,
    Object? vigilanteKillTarget = _unset,
    Object? investigationResult = _unset,
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
      eliminatedPlayer: eliminatedPlayer == _unset
          ? this.eliminatedPlayer
          : eliminatedPlayer as Player?,
      voteResult: voteResult == _unset
          ? this.voteResult
          : voteResult as VoteResult?,
      mafiaKillTarget: mafiaKillTarget == _unset
          ? this.mafiaKillTarget
          : mafiaKillTarget as Player?,
      vigilanteKillTarget: vigilanteKillTarget == _unset
          ? this.vigilanteKillTarget
          : vigilanteKillTarget as Player?,
      investigationResult: investigationResult == _unset
          ? this.investigationResult
          : investigationResult as Teams?,
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
    eliminatedPlayer,
    voteResult,
    mafiaKillTarget,
    vigilanteKillTarget,
    investigationResult,
    winner,
  ];
}
