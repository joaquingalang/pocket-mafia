import 'package:flutter/material.dart';
import 'package:pocket_mafia/theme.dart';

enum Roles {
  mafia,
  detective,
  doctor,
  jester,
  headhunter,
  vigilante,
  mortician,
  lover,
  snitch,
  celebrity,
  preacher,
  medium,
  saboteur,
  villager,
}

enum Teams {
  village,
  killer
}

final Map<Roles, String> roleAbility = {
  Roles.villager: 'You have no special abilities.',
  Roles.mafia: 'Choose a player to kill every night.',
  Roles.detective: 'Investigate one player each night to learn their team.',
  Roles.doctor: 'Choose one player each night to protect from death.',
  Roles.jester: 'You have no night abilities.',
  Roles.headhunter: 'You are assigned a secret target at the start of the game.',
  Roles.vigilante: 'You may kill one player once per game at night.',
  Roles.mortician: 'Learn the role of the player who died that night.',
  Roles.lover: 'You are bonded to another player; if one of you dies, both die.',
  Roles.snitch: 'When you die, reveal two possible suspects.',
  Roles.celebrity: 'Your vote counts as two votes during the day.',
  Roles.preacher: 'Guess who will die each night; gain +1 permanent vote weight for each correct guess.',
  Roles.medium: 'Revive one dead player once per game at night.',
};

final Map<Roles, String> roleWinCondition = {
  Roles.villager: 'The Village wins when all Mafia are eliminated.',
  Roles.mafia: 'The Mafia win when the number of living Mafia is equal to or greater than the number of living Villagers.',
  Roles.detective: 'The Village wins when all Mafia are eliminated.',
  Roles.doctor: 'The Village wins when all Mafia are eliminated.',
  Roles.jester: 'You win if you get voted out during the day.',
  Roles.headhunter: 'You win if your target is voted out during the day.',
  Roles.vigilante: 'The Village wins when all Mafia are eliminated.',
  Roles.mortician: 'The Village wins when all Mafia are eliminated.',
  Roles.lover: 'You win if both Lovers are alive at the end of the game.',
  Roles.snitch: 'The Village wins when all Mafia are eliminated.',
  Roles.celebrity: 'The Village wins when all Mafia are eliminated.',
  Roles.preacher: 'The Village wins when all Mafia are eliminated.',
  Roles.medium: 'The Village wins when all Mafia are eliminated.',
};

final Map<Roles, Color> roleColor = {
  Roles.villager: MiscellaniousColors.gray,
  Roles.mafia: MiscellaniousColors.red,
  Roles.detective: MiscellaniousColors.blue,
  Roles.doctor: MiscellaniousColors.green,
  Roles.jester: Colors.pink,
  Roles.headhunter: Colors.orange,
  Roles.vigilante: Colors.indigo,
  Roles.mortician: Colors.blueGrey,
  Roles.lover: Colors.pinkAccent,
  Roles.snitch: Colors.yellow,
  Roles.celebrity: Colors.deepPurpleAccent,
  Roles.preacher: Colors.brown,
  Roles.medium: Colors.tealAccent,
  Roles.saboteur: Colors.black54,
};