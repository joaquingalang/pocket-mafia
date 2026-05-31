import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';

class GameSettingsState extends Equatable {
  const GameSettingsState({
    this.dayDuration = const Duration(seconds: 300),
    this.nightDuration = const Duration(seconds: 60),
    this.voteDuration = const Duration(seconds: 30),
    this.names = const [],
    this.roles = const [],
  });

  // Persistent Information
  final Duration dayDuration;
  final Duration nightDuration;
  final Duration voteDuration;
  final List<String> names;
  final List<Roles> roles;

  GameSettingsState copyWith({
    Duration? dayDuration,
    Duration? nightDuration,
    Duration? voteDuration,
    List<String>? names,
    List<Roles>? roles,
  }) {
    return GameSettingsState(
      dayDuration: dayDuration ?? this.dayDuration,
      nightDuration: nightDuration ?? this.nightDuration,
      voteDuration: voteDuration ?? this.voteDuration,
      names: names ?? this.names,
      roles: roles ?? this.roles,
    );
  }

  int roleCount(Roles search) {
    int count = 0;
    for (Roles role in roles) {
      if (role == search) {
        count += 1;
      }
    }
    return count;
  }

  @override
  List<Object?> get props => [
    dayDuration,
    nightDuration,
    voteDuration,
    names,
    roles
  ];
}
