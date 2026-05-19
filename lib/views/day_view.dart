import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/game_app_bar.dart';
import 'package:pocket_mafia/components/phase_button.dart';
import 'package:pocket_mafia/components/phase_timer.dart';
import 'package:pocket_mafia/components/player_tile.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/models/game_settings.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/theme.dart';

class DayView extends StatefulWidget {
  const DayView({
    super.key,
    required this.round,
    required this.duration,
    required this.players,
    required this.onPhaseChange,
  });

  final int round;
  final Duration duration;
  final List<Player> players;
  final void Function(Phase) onPhaseChange;

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GameAppBar(
                title: 'Day Discussion',
                subtitle: 'DAY ${widget.round}',
                onClose: () {},
                onInfo: () {},
              ),

              // Offset
              SizedBox(height: 20),

              PhaseTimer(
                duration: widget.duration,
                isPaused: _isPaused,
                onTimeout: () {
                  print('TIMEOUT!!!!');
                },
              ),

              // Offset
              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SURVIVING PLAYERS (${widget.players.length})',
                  style: theme.textTheme.labelSmall,
                ),
              ),

              // Offset
              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: widget.players.length,
                  itemBuilder: (context, index) {
                    return PlayerTile(
                      name: widget.players[index].name,
                      id: index + 1,
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
                    label: _isPaused ? 'RESUME' : 'PAUSE',
                    trailing: Icon(
                      _isPaused ? Icons.play_arrow : Icons.pause,
                      color: TextColors.primaryText,
                      size: 20,
                    ),
                    isPrimary: false,
                    onPressed: () => setState(() => _isPaused = !_isPaused),
                  ),

                  PhaseButton(
                    label: 'VOTE',
                    trailing: SvgPicture.asset(
                      'assets/images/icons/scales_icon.svg',
                      width: 18,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () => widget.onPhaseChange(Phase.voting),
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
