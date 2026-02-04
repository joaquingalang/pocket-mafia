import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/pill_button.dart';
import 'package:pocket_mafia/pages/settings_page.dart';
import 'package:pocket_mafia/pages/tutorial_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Offset
              const SizedBox(height: 24),

              Text('Pocket Mafia', style: theme.textTheme.displaySmall),
              Text('MODERATOR TOOL', style: theme.textTheme.labelMedium),

              // Offset
              const SizedBox(height: 56),

              Image.asset('assets/images/placeholder.png', width: 250),

              const SizedBox(height: 64),

              PillButton(label: 'PLAY', onPressed: () {}),
              PillButton(
                label: 'HOW TO PLAY',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorialPage()),
                ),
              ),
              PillButton(
                label: 'SETTINGS',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
