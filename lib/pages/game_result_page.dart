import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/primary_button.dart';
import 'package:pocket_mafia/components/secondary_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/game.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class GameResultPage extends StatefulWidget {
  const GameResultPage({super.key, required this.game});

  final Game game;

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  final ScrollController _scrollController = ScrollController();

  List<Widget> _buildPlayerRoleTiles() {
    List<Widget> tiles = [];
    for (Player player in widget.game.players!) {
      final tile = _PlayerRoleTile(player: player);
      tiles.add(tile);
    }
    return tiles;
  }

  Future<void> _scrollAfterDelay() async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Offset
                SizedBox(height: 25),

                Container(
                  width: 136,
                  height: 136,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),

                // Offset
                SizedBox(height: 15),

                Text(
                  'VILLAGERS WIN!',
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Offset
                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Container(
                      height: 1,
                      width: 46,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),

                    Text(
                      'GAME OVER',
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),

                    Container(
                      height: 1,
                      width: 46,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),

                // Offset
                SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PLAYER SUMMARY',
                    style: theme.textTheme.labelSmall,
                  ),
                ),

                // Offset
                SizedBox(height: 15),

                ..._buildPlayerRoleTiles(),

                // Offset
                SizedBox(height: 35),

                SecondaryButton(
                  label: 'HOME',
                  iconData: Icons.home,
                  onPressed: () {},
                ),

                // Offset
                SizedBox(height: 10),

                PrimaryButton(
                  label: 'PLAY AGAIN',
                  iconData: Icons.refresh,
                  onPressed: () {},
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

class _PlayerRoleTile extends StatelessWidget {
  const _PlayerRoleTile({super.key, required this.player});

  final Player player;

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
              color: roleColor[player.role.type],
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.name.toTitleCase(),
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                player.role.type.name.toTitleCase(),
                style: theme.textTheme.labelSmall!.copyWith(
                  color: roleColor[player.role.type],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
