import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

class Player extends Equatable {

  Player({required this.name, required this.role, this.isDeceased=false});

  final String name;
  final Role role;
  final bool isDeceased;

  Player copyWith({String? name, Role? role, bool? isDeceased}) {
    return Player(
      name: name ?? this.name,
      role: role ?? this.role,
      isDeceased: isDeceased ?? this.isDeceased,
    );
  }

  @override
  List<Object?> get props => [name, role];

}