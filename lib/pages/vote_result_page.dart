import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/vote_result.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:sizer/sizer.dart';

class VoteResultPage extends StatelessWidget {
  const VoteResultPage({super.key, required this.result, this.player});

  final VoteResult result;
  final Player? player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('THE EXECUTION', style: theme.textTheme.labelSmall),
                  Text(
                    'The Village Has Decided',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),

              Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: SvgPicture.asset(
                    result.getIconPath(),
                  ),
                ),

                // Offset
                SizedBox(height: 30),

                Text(result.getTitle(player!), style: theme.textTheme.displaySmall),

                // Offset
                SizedBox(height: 10),

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
                      result.getSubtitle(player!),
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
                SizedBox(height: 20),

                SizedBox(
                  width: 60.w,
                  child: Text(
                    result.getPhrase(player!),
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

              Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'PROCEEDING TO NIGHT IN 5S...',
                    style: theme.textTheme.labelSmall,
                  ),

                  LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 10,
                    color: theme.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ],
              ),

              // Offset
              SizedBox(height: 15),

              RoundedRectangleButton(
                label: 'PROCEED TO NIGHT',
                iconData: Icons.nightlight_outlined,
                onPressed: () {},
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