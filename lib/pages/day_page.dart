import 'package:flutter/material.dart';
import 'package:pocket_mafia/models/game.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key, required this.game});

  final Game game;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
