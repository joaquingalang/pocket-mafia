import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/components/player_tile.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/game.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/pages/day_page.dart';
import 'package:pocket_mafia/pages/game_summary_page.dart';
import 'package:pocket_mafia/pages/role_reveal_page.dart';
import 'package:pocket_mafia/pages/vote_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class GameSummaryPage extends StatefulWidget {
  const GameSummaryPage({super.key, required this.game});

  final Game game;

  @override
  State<GameSummaryPage> createState() => _GameSummaryPageState();
}

class _GameSummaryPageState extends State<GameSummaryPage> {
  Widget _buildPlayerTiles() {
    List<Widget> playerTiles = [];
    final int playerCount = widget.game.players!.length;
    final int visible = (playerCount <= 5) ? playerCount : 5;
    for (int i = 0; i < visible; i++) {
      final player = widget.game.players![i];
      playerTiles.add(PlayerTile(name: player.name, id: i + 1));
    }
    if (playerCount - visible > 0) {
      playerTiles.add(_MorePlayersTile(count: playerCount - visible));
    }
    return Column(children: playerTiles);
  }

  Widget _buildRoleTiles() {
    List<Widget> roleTiles = [];
    List<Roles> roles = [];
    for (Player player in widget.game.players!) {
      final role = player.role.type;
      roles.add(role);
    }
    for (Roles role in Roles.values) {
      if (roles.contains(role)) {
        roleTiles.add(
          _RoleTile(
            role: role,
            count: roles.where((type) => type == role).length,
          ),
        );
      }
    }
    return Column(children: roleTiles);
  }

  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VotePage(game: widget.game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainAppBar(title: 'Game Summary'),

                // Offset
                SizedBox(height: 35),

                Text('PHASE SETTINGS', style: theme.textTheme.labelSmall),

                // Offset
                SizedBox(height: 15),

                Row(
                  spacing: 10,
                  children: [
                    _PhaseDurationTile(
                      phase: Phase.day,
                      duration: widget.game.dayDuration!,
                    ),
                    _PhaseDurationTile(
                      phase: Phase.night,
                      duration: widget.game.nightDuration!,
                    ),
                    _PhaseDurationTile(
                      phase: Phase.vote,
                      duration: widget.game.voteDuration!,
                    ),
                  ],
                ),

                // Offset
                SizedBox(height: 25),

                Text('PLAYERS', style: theme.textTheme.labelSmall),

                // Offset
                SizedBox(height: 15),

                _buildPlayerTiles(),

                // Offset
                SizedBox(height: 25),

                Text('SELECTED ROLES', style: theme.textTheme.labelSmall),

                // Offset
                SizedBox(height: 15),

                _buildRoleTiles(),

                // Offset
                SizedBox(height: 35),

                RoundedRectangleButton(
                  label: 'START GAME',
                  iconData: Icons.play_arrow_outlined,
                  onPressed: _startGame,
                ),

                // Offset
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MorePlayersTile extends StatelessWidget {
  const _MorePlayersTile({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('+$count more players', style: theme.textTheme.bodyLarge),
    );
  }
}

class _RoleTile extends StatelessWidget {
  const _RoleTile({super.key, required this.role, required this.count});

  final Roles role;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: roleColor[role],
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role.name.toTitleCase(),
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (role == Roles.mafia) ? 'KILLER TEAM' : 'VILLAGER TEAM',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: roleColor[role],
                ),
              ),
            ],
          ),

          Spacer(),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: roleColor[role]!.withOpacity(0.25),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: theme.textTheme.labelLarge!.copyWith(
                  color: roleColor[role],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseDurationTile extends StatelessWidget {
  const _PhaseDurationTile({
    super.key,
    required this.phase,
    required this.duration,
  });

  final Phase phase;
  final Duration duration;

  String getPhaseIcon() {
    switch (phase) {
      case Phase.day:
        return 'sun';
      case Phase.night:
        return 'moon';
      case Phase.vote:
        return 'gavel';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/icons/${getPhaseIcon()}_icon.svg'),
            Text(
              phase.name.toUpperCase(),
              style: theme.textTheme.labelSmall!.copyWith(
                color: const Color(0xFF4E5F79),
              ),
            ),
            Text('${duration.inSeconds}S', style: theme.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
