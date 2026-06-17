import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/components/primary_button.dart';
import 'package:pocket_mafia/components/secondary_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/enums/team_victory.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/pages/game_setup_page.dart';
import 'package:pocket_mafia/pages/home_page.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class GameResultPage extends StatefulWidget {
  const GameResultPage({super.key});

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _scrollAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollAfterDelay();
  }

  String _winnerTitle(TeamVictory? winner) => switch (winner) {
        TeamVictory.village => 'VILLAGERS WIN!',
        TeamVictory.mafia => 'MAFIA WINS!',
        TeamVictory.jester => 'JESTER WINS!',
        TeamVictory.headhunter => 'HEADHUNTER WINS!',
        null => 'GAME OVER',
      };

  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (_) => false,
    );
  }

  void _playAgain(BuildContext context) {
    context.read<GameSessionBloc>().add(const GameReset());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const GameSetupPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSessionBloc, GameSessionState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    Container(
                      width: 136,
                      height: 136,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      _winnerTitle(state.winner),
                      style: theme.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 1, width: 46, color: theme.colorScheme.secondary),
                        const SizedBox(width: 10),
                        Text(
                          'GAME OVER',
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(height: 1, width: 46, color: theme.colorScheme.secondary),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('PLAYER SUMMARY', style: theme.textTheme.labelSmall),
                    ),

                    const SizedBox(height: 15),

                    ...state.players.map((p) => _PlayerRoleTile(player: p)),

                    const SizedBox(height: 35),

                    SecondaryButton(
                      label: 'HOME',
                      iconData: Icons.home,
                      onPressed: _goHome,
                    ),

                    const SizedBox(height: 10),

                    PrimaryButton(
                      label: 'PLAY AGAIN',
                      iconData: Icons.refresh,
                      onPressed: () => _playAgain(context),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerRoleTile extends StatelessWidget {
  const _PlayerRoleTile({required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: roleColor[player.role.type],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name.toTitleCase(),
                  style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      player.role.type.name.toTitleCase(),
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: roleColor[player.role.type],
                      ),
                    ),
                    if (player.isDeceased) ...[
                      const SizedBox(width: 6),
                      Text(
                        '· Eliminated',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
