import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

class Player extends Equatable {

  Player({required this.name, required this.role});

  final String name;
  final Role role;

  @override
  List<Object?> get props => [name, role];

}