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
import 'package:pocket_mafia/theme.dart';

class VotingView extends StatefulWidget {
  const VotingView({
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
  State<VotingView> createState() => _VotingViewState();
}

class _VotingViewState extends State<VotingView> {
  int _voterIndex = 0;
  Player? _selectedTarget;

  List<Player> get _alivePlayers =>
      widget.players.where((p) => !p.isDeceased).toList();

  void _advance({bool skip = false}) {
    final alive = _alivePlayers;
    final currentVoter = alive[_voterIndex];

    if (!skip && _selectedTarget != null) {
      context.read<GameSessionBloc>().add(
        GamePlayerVote(voter: currentVoter, target: _selectedTarget!),
      );
    }

    if (_voterIndex + 1 >= alive.length) {
      context.read<GameSessionBloc>().add(const GameTallyVotes());
      widget.onPhaseChange();
    } else {
      setState(() {
        _voterIndex++;
        _selectedTarget = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alive = _alivePlayers;
    final currentVoter = alive[_voterIndex];
    final targets = alive.where((p) => p != currentVoter).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GameAppBar(
                title: 'Voting Phase',
                subtitle: 'DAY ${widget.round}',
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
                    Text('CURRENT VOTER', style: theme.textTheme.labelSmall),
                    Text(currentVoter.name, style: theme.textTheme.headlineSmall),
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
                  itemCount: targets.length,
                  itemBuilder: (context, index) {
                    final player = targets[index];
                    return PlayerSelectTile(
                      name: player.name,
                      id: widget.players.indexOf(player) + 1,
                      value: player == _selectedTarget,
                      onChanged: (checked) => setState(() {
                        _selectedTarget = (checked == true) ? player : null;
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
                    label: 'SKIP VOTE',
                    trailing: SvgPicture.asset(
                      'assets/images/icons/peace_icon.svg',
                      width: 18,
                      color: theme.colorScheme.onTertiary,
                    ),
                    isPrimary: false,
                    onPressed: () => _advance(skip: true),
                  ),

                  PhaseButton(
                    label: 'CONFIRM',
                    trailing: SvgPicture.asset(
                      'assets/images/icons/check_circle_icon.svg',
                      width: 18,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      if (_selectedTarget != null) _advance();
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
