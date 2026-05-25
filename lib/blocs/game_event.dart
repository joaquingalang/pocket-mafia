import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

sealed class GameEvent extends Equatable{
  const GameEvent();
}

// Player
final class GameAddPlayer extends GameEvent {
  const GameAddPlayer({required this.name});
  final String name;

  @override
  List<Object?> get props => [name];
}

final class GameRemovePlayer extends GameEvent {
  const GameRemovePlayer({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Phase Duration
final class GameSetDayDuration extends GameEvent {
  const GameSetDayDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSetVoteDuration extends GameEvent {
  const GameSetVoteDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class GameSetNightDuration extends GameEvent {
  const GameSetNightDuration({required this.duration});
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

// Roles
final class GameAddRole extends GameEvent {
  const GameAddRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

final class GameRemoveRole extends GameEvent {
  const GameRemoveRole({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

// Player + Roles
final class GameAssignPlayerRoles extends GameEvent {
  const GameAssignPlayerRoles();

  @override
  List<Object?> get props => [];
}

// Vote
final class GameVillageVote extends GameEvent {
  const GameVillageVote();

  @override
  List<Object?> get props => [];
}

// Role Actions
final class GameMafiaKill extends GameEvent {
  const GameMafiaKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDetectiveInvestigate extends GameEvent {
  const GameDetectiveInvestigate({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDoctorHeal extends GameEvent {
  const GameDoctorHeal({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameVigilanteKill extends GameEvent {
  const GameVigilanteKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Role Wins
final class GameMafiaWin extends GameEvent {
  const GameMafiaWin();

  @override
  List<Object?> get props => [];
}

final class GameVillageWin extends GameEvent {
  const GameVillageWin();

  @override
  List<Object?> get props => [];
}

final class GameJesterWin extends GameEvent {
  const GameJesterWin();

  @override
  List<Object?> get props => [];
}

final class GameHeadhunterWin extends GameEvent {
  const GameHeadhunterWin();

  @override
  List<Object?> get props => [];
}

// Reset
final class GameReset extends GameEvent {
  const GameReset();

  @override
  List<Object?> get props => [];
}