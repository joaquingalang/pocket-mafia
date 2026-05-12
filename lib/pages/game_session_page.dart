import 'package:flutter/material.dart';
import 'package:pocket_mafia/models/game_settings.dart';
import 'package:pocket_mafia/models/player.dart';

class GameSessionPage extends StatefulWidget {
  const GameSessionPage({super.key, required this.settings});

  final GameSettings settings;

  @override
  State<GameSessionPage> createState() => _GameSessionPageState();
}

class _GameSessionPageState extends State<GameSessionPage> {

  late final Duration? dayDuration;
  late final Duration? nightDuration;
  late final Duration? voteDuration;
  late final List<Player>? players;

  @override
  void initState() {
    super.initState();
    final GameSettings(:dayDuration, :nightDuration, :voteDuration, :players) = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    print(dayDuration);
    return const Placeholder();
  }
}
