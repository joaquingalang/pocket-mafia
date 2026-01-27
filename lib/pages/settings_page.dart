import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _isDarkTheme = true;
  bool _revealDeadRoles = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainAppBar(label: 'Game Settings'),

              // Offset
              SizedBox(height: 35),

              Text('GENERAL PREFERENCES', style: theme.textTheme.labelSmall),

              // Offset
              SizedBox(height: 12),

              // General Preference Settings
              SettingsTileGroup(
                tiles: [
                  SettingsSwitchListTile(
                    label: 'Dark Theme',
                    iconData: Icons.nightlight_round,
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() => _isDarkTheme = value);
                    },
                  ),
                  SettingsListTile(
                    label: 'Narrator Voice',
                    trailingText: 'English (US)',
                    iconData: Icons.record_voice_over,
                    onPressed: () {},
                  ),
                  SettingsSwitchListTile(
                    label: 'Reveal dead roles',
                    iconData: Icons.remove_red_eye,
                    value: _revealDeadRoles,
                    onChanged: (value) {
                      setState(() => _revealDeadRoles = value);
                    },
                  ),
                ],
              ),

              // Offset
              SizedBox(height: 25),

              Text('SUPPORT', style: theme.textTheme.labelSmall),

              // Offset
              SizedBox(height: 12),

              // General Preference Settings
              SettingsTileGroup(
                tiles: [
                  SettingsListTile(
                    label: 'About Game',
                    iconData: Icons.info,
                    onPressed: () {},
                  ),
                  SettingsListTile(
                    label: 'FAQs',
                    iconData: Icons.question_mark,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.label,
    required this.iconData,
    required this.onPressed,
    this.trailingText,
    this.borderRadius,
  });

  final String label;
  final String? trailingText;
  final IconData iconData;
  final VoidCallback onPressed;
  final BorderRadiusGeometry? borderRadius;

  SettingsListTile copyWith({
    String? label,
    IconData? iconData,
    VoidCallback? onPressed,
    String? trailingText,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SettingsListTile(
      label: label ?? this.label,
      iconData: iconData ?? this.iconData,
      onPressed: onPressed ?? this.onPressed,
      trailingText: trailingText ?? this.trailingText,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Icon(iconData, color: Colors.white, size: 18)),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: TextColors.secondaryText,
              ),
            ),
          Icon(Icons.keyboard_arrow_right, color: TextColors.secondaryText),
        ],
      ),
      contentPadding: EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
      ),
      tileColor: theme.colorScheme.secondary,
      splashColor: theme.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
    );
  }
}


class SettingsSwitchListTile extends StatelessWidget {
  const SettingsSwitchListTile({
    super.key,
    required this.label,
    required this.iconData,
    required this.value,
    required this.onChanged,
    this.borderRadius,
  });

  final String label;
  final IconData iconData;
  final bool value;
  final Function(bool) onChanged;
  final BorderRadiusGeometry? borderRadius;

  SettingsSwitchListTile copyWith({
    String? label,
    IconData? iconData,
    Function(bool?)? onChanged,
    bool? value,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SettingsSwitchListTile(
      label: label ?? this.label,
      iconData: iconData ?? this.iconData,
      onChanged: onChanged ?? this.onChanged,
      value: value ?? this.value,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      secondary: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Icon(iconData, color: Colors.white, size: 18)),
      ),
      contentPadding: EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
      ),
      activeThumbColor: theme.colorScheme.onSecondary,
      inactiveThumbColor: theme.colorScheme.secondary,
      inactiveTrackColor: theme.colorScheme.primary,
      tileColor: theme.colorScheme.secondary,
      trackOutlineColor: MaterialStateProperty.resolveWith(
            (final Set<MaterialState> states) {
          if (!states.contains(MaterialState.selected)) {
            return Colors.transparent;
          }
          return null;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
    );
  }
}

class SettingsTileGroup extends StatelessWidget {
  const SettingsTileGroup({super.key, required this.tiles});

  final List tiles;

  List<Widget> _buildTiles() {
    List<Widget> settingTiles = [];
    final divider = const Divider(
      color: Color(0xFF4E5F79),
      thickness: 1,
      height: 1,
    );
    for (int i = 0; i < tiles.length; i++) {
      var tile = tiles[i];

      if (i == 0) {
        final topTile = tile.copyWith(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        );
        settingTiles.add(topTile);
      } else if (i > 0 && i < tiles.length - 1) {
        settingTiles.add(tile);
      } else {
        final bottomTile = tile.copyWith(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        );
        settingTiles.add(bottomTile);
        continue;
      }
      settingTiles.add(divider);
    }

    return settingTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildTiles());
  }
}
