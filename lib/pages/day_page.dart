import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/game_app_bar.dart';
import 'package:pocket_mafia/components/phase_timer.dart';
import 'package:pocket_mafia/components/player_tile.dart';
import 'package:pocket_mafia/models/game.dart';
import 'package:pocket_mafia/theme.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key, required this.game});

  final Game game;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
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
                subtitle: 'DAY 1',
                onClose: () {},
                onInfo: () {},
              ),

              // Offset
              SizedBox(height: 20),

              PhaseTimer(
                duration: widget.game.dayDuration!,
                onTimeout: () {
                  print('TIMEOUT!!!!');
                },
              ),

              // Offset
              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SURVIVING PLAYERS (8)',
                  style: theme.textTheme.labelSmall,
                ),
              ),

              // Offset
              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: widget.game.players!.length,
                  itemBuilder: (context, index) {
                    return PlayerTile(
                      name: widget.game.players![index].name,
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
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text('PAUSE', style: theme.textTheme.labelLarge),
                          Icon(
                            Icons.pause,
                            color: TextColors.primaryText,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            'VOTE',
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/icons/scales_icon.svg',
                            width: 18,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
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