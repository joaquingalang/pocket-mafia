import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/models/player.dart';

class GameState extends Equatable {
  const GameState({
    this.dayDuration = const Duration(seconds: 300),
    this.nightDuration = const Duration(seconds: 60),
    this.voteDuration = const Duration(seconds: 30),
    this.players = const [],
    this.phase = Phase.day,
    this.round = 1,
    this.isVoting = false,
  });

  // Phase & Rounds
  final Duration dayDuration;
  final Duration nightDuration;
  final Duration voteDuration;
  final int round;
  final bool isVoting;

  // Players
  final List<Player> players;

  // Phase
  final Phase phase;

  GameState copyWith({
    Duration? dayDuration,
    Duration? nightDuration,
    Duration? voteDuration,
    List<Player>? players,
    Phase? phase,
    int? round,
    bool? isVoting,
  }) {
    return GameState(
      dayDuration: dayDuration ?? this.dayDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      players: players ?? this.players,
      phase: phase ?? this.phase,
      round: round ?? this.round,
      isVoting: isVoting ?? this.isVoting,
    );
  }

  @override
  List<Object?> get props => [
    dayDuration,
    nightDuration,
    voteDuration,
    players,
    phase,
    round,
    isVoting,
  ];
}
