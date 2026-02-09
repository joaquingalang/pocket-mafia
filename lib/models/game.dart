import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';

class Game {
  final Duration? dayDuration;
  final Duration? nightDuration;
  final Duration? voteDuration;
  final List<Player>? players;

  const Game({
    this.dayDuration,
    this.nightDuration,
    this.voteDuration,
    this.players,
  });

  Game copyWith({
    Duration? dayDuration,
    Duration? nightDuration,
    Duration? voteDuration,
    List<Player>? players,
  }) {
    return Game(
      dayDuration: dayDuration ?? this.dayDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      players: players ?? this.players,
    );
  }

}
