import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/pages/game_summary_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';

class RoleSelectPage extends StatefulWidget {
  const RoleSelectPage({super.key});

  @override
  State<RoleSelectPage> createState() => _RoleSelectPageState();
}

class _RoleSelectPageState extends State<RoleSelectPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              MainAppBar(label: 'Select Roles'),

              // Offset
              SizedBox(height: 35),

              TotalPlayerTile(count: 8),

              // Offset
              SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 11 / 12,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: Role.values.length,
                  itemBuilder: (context, index) {
                    final role = Role.values[index];
                    return RoleCard(role: role);
                  },
                ),
              ),

              // Offset
              SizedBox(height: 15),

              RoundedRectangleButton(
                label: 'REVIEW SETTINGS',
                iconData: Icons.arrow_forward,
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
    );
  }
}

class RoleCard extends StatefulWidget {
  const RoleCard({super.key, required this.role});

  final Role role;

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  int _roleCount = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF43F5E),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.info,
                  color: theme.colorScheme.onSecondary,
                  size: 24,
                ),
              ),
            ],
          ),
          // Offset
          SizedBox(height: 8),
          Text(
            widget.role.name.toTitleCase(),
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            (widget.role == Role.mafia) ? 'KILLER TEAM' : 'VILLAGER TEAM',
            style: theme.textTheme.labelSmall,
          ),

          // Offset
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoleIncrementButton(
                  iconData: Icons.remove,
                  onPressed: () => setState(() {
                    if (_roleCount > 0) {
                      _roleCount -= 1;
                    }
                  }),
                ),
                Text(_roleCount.toString(), style: theme.textTheme.labelLarge),
                RoleIncrementButton(
                  iconData: Icons.add,
                  onPressed: () => setState(() {
                    _roleCount += 1;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoleIncrementButton extends StatefulWidget {
  const RoleIncrementButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  State<RoleIncrementButton> createState() => _RoleIncrementButtonState();
}

class _RoleIncrementButtonState extends State<RoleIncrementButton> {
  bool _isPressed = false;

  Future<void> _handlePress(bool pressed) async {
    setState(() {
      _isPressed = pressed;
    });

    if (!pressed) {
      await Future.delayed(const Duration(milliseconds: 50));
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (details) => _handlePress(true),
          onTapUp: (details) => _handlePress(false),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF4E5F79),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              widget.iconData,
              color: TextColors.primaryText,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class TotalPlayerTile extends StatelessWidget {
  const TotalPlayerTile({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PLAYERS CONFIGURED',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                spacing: 8,
                children: [
                  Text(
                    count.toString(),
                    style: theme.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text('TOTAL', style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: SizedBox(
              width: 30,
              child: SvgPicture.asset('assets/images/icons/players_icon.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
