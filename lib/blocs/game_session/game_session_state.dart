import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/models/player.dart';

class GameSessionState extends Equatable {
  const GameSessionState({
    this.players = const [],
    this.phase = Phase.day,
    this.round = 1,
    this.isVoting = false,
  });

  final List<Player> players;
  final int round;
  final bool isVoting;
  final Phase phase;

  GameSessionState copyWith({
    List<Player>? players,
    int? round,
    bool? isVoting,
    Phase? phase,
  }) {
    return GameSessionState(
      players: players ?? this.players,
      round: round ?? this.round,
      isVoting: isVoting ?? this.isVoting,
      phase: phase ?? this.phase,
    );
  }

  @override
  List<Object?> get props => [players, round, isVoting, phase];
}
