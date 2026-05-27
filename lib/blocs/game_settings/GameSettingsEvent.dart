import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

sealed class GameSettingsEvent extends Equatable {
  const GameSettingsEvent();
}

// Player
final class GameAddPlayer extends GameSettingsEvent {
  const GameAddPlayer({required this.name});
  final String name;

  @override
  List<Object?> get props => [name];
}

final class GameRemovePlayer extends GameSettingsEvent {
  const GameRemovePlayer({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Phase Duration
final class GameSetDayDuration extends GameSettingsEvent {
  const GameSetDayDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSetVoteDuration extends GameSettingsEvent {
  const GameSetVoteDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSetNightDuration extends GameSettingsEvent {
  const GameSetNightDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

// Roles
final class GameAddRole extends GameSettingsEvent {
  const GameAddRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

final class GameRemoveRole extends GameSettingsEvent {
  const GameRemoveRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

// Player + Roles
final class GameAssignPlayerRoles extends GameSettingsEvent {
  const GameAssignPlayerRoles();

  @override
  List<Object?> get props => [];
}

// Vote
final class GameVillageVote extends GameSettingsEvent {
  const GameVillageVote();

  @override
  List<Object?> get props => [];
}

// Role Actions
final class GameMafiaKill extends GameSettingsEvent {
  const GameMafiaKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDetectiveInvestigate extends GameSettingsEvent {
  const GameDetectiveInvestigate({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDoctorHeal extends GameSettingsEvent {
  const GameDoctorHeal({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameVigilanteKill extends GameSettingsEvent {
  const GameVigilanteKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Role Wins
final class GameMafiaWin extends GameSettingsEvent {
  const GameMafiaWin();

  @override
  List<Object?> get props => [];
}

final class GameVillageWin extends GameSettingsEvent {
  const GameVillageWin();

  @override
  List<Object?> get props => [];
}

final class GameJesterWin extends GameSettingsEvent {
  const GameJesterWin();

  @override
  List<Object?> get props => [];
}

final class GameHeadhunterWin extends GameSettingsEvent {
  const GameHeadhunterWin();

  @override
  List<Object?> get props => [];
}

// Reset
final class GameReset extends GameSettingsEvent {
  const GameReset();

  @override
  List<Object?> get props => [];
}