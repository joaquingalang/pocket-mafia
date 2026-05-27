import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

sealed class GameSettingsEvent extends Equatable {
  const GameSettingsEvent();
}

// Player
final class GameSettingsAddPlayer extends GameSettingsEvent {
  const GameSettingsAddPlayer({required this.name});
  final String name;

  @override
  List<Object?> get props => [name];
}

final class GameSettingsRemovePlayer extends GameSettingsEvent {
  const GameSettingsRemovePlayer({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Phase Duration
final class GameSettingsSetDayDuration extends GameSettingsEvent {
  const GameSettingsSetDayDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSettingsSetVoteDuration extends GameSettingsEvent {
  const GameSettingsSetVoteDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSettingsSetNightDuration extends GameSettingsEvent {
  const GameSettingsSetNightDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

// Roles
final class GameSettingsAddRole extends GameSettingsEvent {
  const GameSettingsAddRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

final class GameSettingsRemoveRole extends GameSettingsEvent {
  const GameSettingsRemoveRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}