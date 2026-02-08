import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class Player {

  Player({required this.name, required this.role});

  final String name;
  final Roles role;

  String get roleName {
    String roleName = '';
    for (int i = 0; i < role.name.length; i++) {
      if (i < 0) {
        roleName += role.name[i].toUpperCase();
        continue;
      }
      if (isUppercase(role.name[i])) {
        roleName += ' ${role.name[i].toUpperCase()}';
      }
    }
    return roleName;
  }

}