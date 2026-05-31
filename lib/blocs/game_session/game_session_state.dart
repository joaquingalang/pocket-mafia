import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/models/player.dart';

class GameSessionState extends Equatable {
  const GameSessionState({
    this.players = const [],
    this.dayDuration = const Duration(seconds: 300),
    this.nightDuration = const Duration(seconds: 60),
    this.voteDuration = const Duration(seconds: 30),
    this.phase = Phase.day,
    this.round = 1,
    this.isVoting = false,
  });

  final List<Player> players;
  final Duration dayDuration;
  final Duration nightDuration;
  final Duration voteDuration;
  final int round;
  final bool isVoting;
  final Phase phase;

  GameSessionState copyWith({
    List<Player>? players,
    Duration? dayDuration,
    Duration? voteDuration,
    Duration? nightDuration,
    int? round,
    bool? isVoting,
    Phase? phase,
  }) {
    return GameSessionState(
      players: players ?? this.players,
      dayDuration: dayDuration ?? this.dayDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      round: round ?? this.round,
      isVoting: isVoting ?? this.isVoting,
      phase: phase ?? this.phase,
    );
  }

  @override
  List<Object?> get props => [players, round, isVoting, phase];
}
