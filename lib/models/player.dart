import 'package:equatable/equatable.dart';
import 'package:pocket_mafia/models/role.dart';

class Player extends Equatable {

  Player({required this.name, required this.role, this.isDeceased = false, this.loverPartner});

  final String name;
  final Role role;
  final bool isDeceased;
  final String? loverPartner;

  Player copyWith({String? name, Role? role, bool? isDeceased, Object? loverPartner = _unset}) {
    return Player(
      name: name ?? this.name,
      role: role ?? this.role,
      isDeceased: isDeceased ?? this.isDeceased,
      loverPartner: loverPartner == _unset ? this.loverPartner : loverPartner as String?,
    );
  }

  static const Object _unset = Object();

  @override
  List<Object?> get props => [name, role];

}