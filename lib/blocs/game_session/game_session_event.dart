import 'package:equatable/equatable.dart';

sealed class GameSessionEvent extends Equatable {
  const GameSessionEvent();
}

// Player + Roles
final class GameAssignRoles extends GameSessionEvent {
  const GameAssignRoles();

  @override
  List<Object?> get props => [];
}

// Vote
final class GameVillageVote extends GameSessionEvent {
  const GameVillageVote();

  @override
  List<Object?> get props => [];
}

// Role Actions
final class GameMafiaKill extends GameSessionEvent {
  const GameMafiaKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDetectiveInvestigate extends GameSessionEvent {
  const GameDetectiveInvestigate({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameDoctorHeal extends GameSessionEvent {
  const GameDoctorHeal({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

final class GameVigilanteKill extends GameSessionEvent {
  const GameVigilanteKill({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

// Role Wins
final class GameMafiaWin extends GameSessionEvent {
  const GameMafiaWin();

  @override
  List<Object?> get props => [];
}

final class GameVillageWin extends GameSessionEvent {
  const GameVillageWin();

  @override
  List<Object?> get props => [];
}

final class GameJesterWin extends GameSessionEvent {
  const GameJesterWin();

  @override
  List<Object?> get props => [];
}

final class GameHeadhunterWin extends GameSessionEvent {
  const GameHeadhunterWin();

  @override
  List<Object?> get props => [];
}

// Reset
final class GameReset extends GameSessionEvent {
  const GameReset();

  @override
  List<Object?> get props => [];
}