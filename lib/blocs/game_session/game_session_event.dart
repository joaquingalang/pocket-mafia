import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/player.dart';

sealed class GameSessionEvent extends Equatable {
  const GameSessionEvent();
}

// Submit Duration
final class GameSetPhaseDurations extends GameSessionEvent {
  const GameSetPhaseDurations({
    required this.dayDuration,
    required this.voteDuration,
    required this.nightDuration,
  });

  final Duration dayDuration;
  final Duration nightDuration;
  final Duration voteDuration;

  @override
  List<Object?> get props => [dayDuration, voteDuration, nightDuration];
}

final class GameSetPhase extends GameSessionEvent {
  const GameSetPhase({required this.phase});

  final Phase phase;

  @override
  List<Object?> get props => [phase];
}

// Player + Roles
final class GameAssignRoles extends GameSessionEvent {
  const GameAssignRoles({required this.names, required this.roles});

  final List<String> names;
  final List<Roles> roles;

  @override
  List<Object?> get props => [names, roles];
}

// Vote
final class GameBuildVoteMap extends GameSessionEvent {
  const GameBuildVoteMap();

  @override
  List<Object?> get props => [];
}

final class GamePlayerVote extends GameSessionEvent {
  const GamePlayerVote({required this.voter, required this.target});
  final Player voter;
  final Player target;

  @override
  List<Object?> get props => [voter, target];
}

final class GameTallyVotes extends GameSessionEvent {
  const GameTallyVotes();

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
