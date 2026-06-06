import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/components/game_app_bar.dart';
import 'package:pocket_mafia/components/phase_button.dart';
import 'package:pocket_mafia/components/phase_timer.dart';
import 'package:pocket_mafia/components/player_select_tile.dart';
import 'package:pocket_mafia/models/player.dart';

class NightView extends StatefulWidget {
  const NightView({
    super.key,
    required this.round,
    required this.duration,
    required this.players,
    required this.onPhaseChange,
  });

  final int round;
  final Duration duration;
  final List<Player> players;
  final VoidCallback onPhaseChange;

  @override
  State<NightView> createState() => _NightViewState();
}

class _NightViewState extends State<NightView> {
  Player? _selectedPlayer;

  List<Player> get _alivePlayers =>
      widget.players.where((p) => !p.isDeceased).toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alive = _alivePlayers;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GameAppBar(
                title: 'Night Action',
                subtitle: 'NIGHT ${widget.round}',
                onClose: () {},
                onInfo: () {},
              ),

              // Offset
              SizedBox(height: 20),

              PhaseTimer(
                duration: widget.duration,
                onTimeout: () {
                  print('TIMEOUT!!!!');
                },
              ),

              // Offset
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('MAFIA', style: theme.textTheme.headlineSmall),
                    Text(
                      'CHOOSE YOUR VICTIM',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),

              // Offset
              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SELECT A PLAYER TO LYNCH',
                  style: theme.textTheme.labelSmall,
                ),
              ),

              // Offset
              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: alive.length,
                  itemBuilder: (context, index) {
                    final player = alive[index];
                    return PlayerSelectTile(
                      name: player.name,
                      id: widget.players.indexOf(player) + 1,
                      value: player == _selectedPlayer,
                      onChanged: (checked) => setState(() {
                        _selectedPlayer = (checked == true) ? player : null;
                      }),
                    );
                  },
                ),
              ),

              // Offset
              SizedBox(height: 20),

              Row(
                spacing: 12,
                children: [
                  PhaseButton(
                    label: 'CONFIRM',
                    trailing: SvgPicture.asset(
                      'assets/images/icons/check_circle_icon.svg',
                      width: 18,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      if (_selectedPlayer == null) return;
                      context.read<GameSessionBloc>().add(
                        GameMafiaKill(
                          index: widget.players.indexOf(_selectedPlayer!),
                        ),
                      );
                      widget.onPhaseChange();
                    },
                  ),
                ],
              ),

              // Offset
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
