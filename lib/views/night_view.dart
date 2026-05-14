import 'package:flutter/material.dart';
import 'package:pocket_mafia/models/player.dart';

class NightView extends StatefulWidget {
  const NightView({super.key, required this.duration, required this.players});

  final Duration duration;
  final List<Player> players;

  @override
  State<NightView> createState() => _NightViewState();
}

class _NightViewState extends State<NightView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
