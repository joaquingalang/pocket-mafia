import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
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

              RoundedRectangleButton(label: 'PLAY', onPressed: () {}),
              RoundedRectangleButton(label: 'HOW TO PLAY', onPressed: () {}),
              RoundedRectangleButton(label: 'SETTINGS', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
