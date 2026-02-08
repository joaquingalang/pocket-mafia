import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class Role {

  final Roles type;
  final String? name;
  final Teams? team;
  final String? ability;
  final String? winCondition;
  final int? count;

  const Role({
    required this.type,
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
      type: role,
      name: name,
      team: team,
      ability: ability,
      winCondition: winCondition,
      count: 0
    );
  }

  Role copyWith({Roles? role, String? name, Teams? team, String? ability, int? count}) {
    return Role(
      type: role ?? this.type,
      name: name ?? this.name,
      team: team ?? this.team,
      ability: ability ?? this.ability,
      count: count ?? this.count,
    );
  }

}
