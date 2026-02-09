import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/game.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/models/role.dart';
import 'package:pocket_mafia/pages/day_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';
import 'package:sizer/sizer.dart';

class RoleRevealPage extends StatefulWidget {
  const RoleRevealPage({super.key, required this.game});

  final Game game;

  @override
  State<RoleRevealPage> createState() => _RoleRevealPageState();
}

class _RoleRevealPageState extends State<RoleRevealPage> {
  int _index = 0;
  bool _isHidden = true;

  void _nextPlayer() {
    setState(() {
      _isHidden = true;

      if (_index < widget.game.players!.length - 1) {
        _index++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DayPage(game: widget.game)),
        );
      }
    });
  }

  bool _isLastPlayer() {
    return _index >= widget.game.players!.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Player Allocated
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PLAYER ${_index + 1} OF ${widget.game.players!.length}',
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    'Pass To ${widget.game.players![_index].name}',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),

              Spacer(),

              (_isHidden)
                  ? _HiddenRole(
                      onReveal: () => setState(() {
                        _isHidden = false;
                      }),
                    )
                  : _RevealedRole(role: widget.game.players![_index].role),

              Spacer(),

              RoundedRectangleButton(
                label: !_isLastPlayer() ? 'I UNDERSTAND' : 'BEGIN DISCUSSION',
                iconData: Icons.arrow_forward,
                onPressed: !_isHidden ? _nextPlayer : () {},
                isDisabled: _isHidden,
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

class _HiddenRole extends StatelessWidget {
  const _HiddenRole({super.key, required this.onReveal});

  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: onReveal,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(1000),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: theme.colorScheme.onSecondary.withOpacity(0.25),
                ),
                BoxShadow(
                  blurRadius: 100,
                  color: theme.colorScheme.onSecondary.withOpacity(0.50),
                ),
              ],
            ),
            child: Icon(
              Icons.remove_red_eye,
              color: theme.colorScheme.primary,
              size: 22.w,
            ),
          ),
        ),

        // Offset
        SizedBox(height: 15),

        Text(
          'REVEAL',
          style: theme.textTheme.headlineLarge!.copyWith(
            color: theme.colorScheme.onSecondary,
            // fontWeight: FontWeight.bold,
          ),
        ),

        // Offset
        SizedBox(height: 10),

        Text(
          'Tap To Reveal Your Secret Role',
          style: theme.textTheme.labelMedium,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}

class _RevealedRole extends StatelessWidget {
  const _RevealedRole({super.key, required this.role});

  final Role role;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: roleColor[role.type],
              borderRadius: BorderRadius.circular(1000),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: theme.colorScheme.onSecondary.withOpacity(0.25),
                ),
                BoxShadow(
                  blurRadius: 100,
                  color: theme.colorScheme.onSecondary.withOpacity(0.50),
                ),
              ],
            ),
            child: SizedBox(width: 22.w, height: 22.w),
          ),

          // Offset
          SizedBox(height: 20),

          Text(role.name!, style: theme.textTheme.displaySmall),

          // Offset
          SizedBox(height: 20),

          _RoleInfoTile(
            label: 'TEAM',
            body: role.team!.name.toString().toTitleCase(),
            iconPath: 'assets/images/icons/players_icon.svg',
          ),

          _RoleInfoTile(
            label: 'ABILITY',
            body: role.ability!,
            iconPath: 'assets/images/icons/lightning_icon.svg',
          ),

          _RoleInfoTile(
            label: 'WIN CONDITION',
            body: role.winCondition!,
            iconPath: 'assets/images/icons/trophy_icon.svg',
          ),
        ],
      ),
    );
  }
}

class _RoleInfoTile extends StatelessWidget {
  const _RoleInfoTile({
    super.key,
    required this.label,
    required this.body,
    required this.iconPath,
  });

  final String label;
  final String body;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary.withOpacity(0.20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 25,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.labelSmall),
                Text(body, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
