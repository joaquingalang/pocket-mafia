sealed class GameEvent {}

// Player
final class GameAddPlayer extends GameEvent {}
final class GameRemovePlayer extends GameEvent {}

// Phase Duration
final class GameSetDayDuration extends GameEvent {}
final class GameSetVoteDuration extends GameEvent {}
final class GameSetNightDuration extends GameEvent {}

// Roles
final class GameAddRole extends GameEvent {}
final class GameRemoveRole extends GameEvent {}

// Vote
final class GameVillageVote extends GameEvent {}

// Role Actions
final class GameMafiaKill extends GameEvent {}
final class GameDetectiveInvestigate extends GameEvent {}
final class GameDoctorHeal extends GameEvent {}
final class GameVigilanteKill extends GameEvent {}

// Role Wins
final class GameMafiaWin extends GameEvent {}
final class GameVillageWin extends GameEvent {}
final class GameJesterWin extends GameEvent {}
final class GameHeadhunterWin extends GameEvent {}
