import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';

class GameSettings {
  final Duration? dayDuration;
  final Duration? nightDuration;
  final Duration? voteDuration;
  final List<Player>? players;

  const GameSettings({
    this.dayDuration,
    this.nightDuration,
    this.voteDuration,
    this.players,
  });

  GameSettings copyWith({
    Duration? dayDuration,
    Duration? nightDuration,
    Duration? voteDuration,
    List<Player>? players,
  }) {
    return GameSettings(
      dayDuration: dayDuration ?? this.dayDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      players: players ?? this.players,
    );
  }

}
