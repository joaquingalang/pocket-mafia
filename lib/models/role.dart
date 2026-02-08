import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class Role {

  final Roles role;
  final String? name;
  final Teams? team;
  final String? ability;
  final String? winCondition;
  final int? count;

  const Role({
    required this.role,
    this.name,
    this.team,
    this.ability,
    this.winCondition,
    this.count,
  });

  factory Role.initFields(Roles role) {
    final name = role.name.toTitleCase();
    final team = (role == Roles.mafia) ? Teams.killer : Teams.village;
    final ability = roleAbility[role];
    final winCondition = roleWinCondition[role];
    return Role(
      role: role,
      name: name,
      team: team,
      ability: ability,
      winCondition: winCondition,
      count: 0
    );
  }

}
