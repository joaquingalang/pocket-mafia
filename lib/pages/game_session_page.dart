import 'package:flutter/material.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/models/game_settings.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/views/day_view.dart';
import 'package:pocket_mafia/views/night_view.dart';
import 'package:pocket_mafia/views/voting_view.dart';

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

  Phase phase = Phase.day;
  bool isVoting = false;

  Widget getPhaseView() {
    switch (phase) {
      case Phase.day:
        return DayView(duration: dayDuration!, players: players!);
      case Phase.night:
        return NightView(duration: nightDuration!, players: players!);
      case Phase.voting:
        return VotingView(duration: voteDuration!, players: players!);
    }
  }

  @override
  void initState() {
    super.initState();
    dayDuration = widget.settings.dayDuration;
    nightDuration = widget.settings.nightDuration;
    voteDuration = widget.settings.voteDuration;
    players = widget.settings.players;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VotingView(duration: dayDuration!, players: players!),
    );
  }
}
