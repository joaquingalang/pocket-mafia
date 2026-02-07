import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/pages/game_summary_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class GameSummaryPage extends StatefulWidget {
  const GameSummaryPage({super.key});

  @override
  State<GameSummaryPage> createState() => _GameSummaryPageState();
}

class _GameSummaryPageState extends State<GameSummaryPage> {
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
                MainAppBar(label: 'Game Summary'),
            
                // Offset
                SizedBox(height: 35),
            
                Text('PHASE SETTINGS', style: theme.textTheme.labelSmall),
            
                // Offset
                SizedBox(height: 15),
            
                Row(
                  spacing: 10,
                  children: [
                    _PhaseDurationTile(phase: Phase.day),
                    _PhaseDurationTile(phase: Phase.night),
                    _PhaseDurationTile(phase: Phase.vote),
                  ],
                ),
            
                // Offset
                SizedBox(height: 25),
            
                Text('PLAYERS', style: theme.textTheme.labelSmall),
            
                // Offset
                SizedBox(height: 15),
            
                _PlayerTile(name: 'Alex Carter', id: 1),
                _PlayerTile(name: 'Alex Carter', id: 2),
                _PlayerTile(name: 'Alex Carter', id: 3),
                _PlayerTile(name: 'Alex Carter', id: 4),
            
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+6 more players',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
            
                // Offset
                SizedBox(height: 25),
            
                Text('SELECTED ROLES', style: theme.textTheme.labelSmall),
            
                // Offset
                SizedBox(height: 15),
            
                _RoleTile(
                  role: Role.mafia,
                  count: 2,
                ),
                _RoleTile(
                  role: Role.detective,
                  count: 1,
                ),
                _RoleTile(
                  role: Role.doctor,
                  count: 1,
                ),
            
                // Offset
                SizedBox(height: 35),
            
                RoundedRectangleButton(
                  label: 'START GAME',
                  iconData: Icons.play_arrow_outlined,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameSummaryPage()),
                  ),
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

class _RoleTile extends StatelessWidget {
  const _RoleTile({
    super.key,
    required this.role,
    required this.count,
  });

  final Role role;
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
              color: const Color(0xFFF43F5E),
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
                (role == Role.mafia) ? 'KILLER TEAM' : 'VILLAGER TEAM',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: const Color(0xFFF43F5E),
                ),
              ),
            ],
          ),

          Spacer(),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF43F5E).withOpacity(0.25),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: Text(
                '3',
                style: theme.textTheme.labelLarge!.copyWith(
                  color: const Color(0xFFF43F5E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerTile extends StatelessWidget {
  const _PlayerTile({super.key, required this.name, required this.id});

  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: theme.textTheme.labelLarge),
          Text(
            '#$id',
            style: theme.textTheme.labelLarge!.copyWith(
              color: const Color(0xFF4E5F79),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseDurationTile extends StatelessWidget {
  const _PhaseDurationTile({super.key, required this.phase});

  final Phase phase;

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
            Text('300S', style: theme.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
