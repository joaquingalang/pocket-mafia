import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/vote_result.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:sizer/sizer.dart';

class VoteResultPage extends StatefulWidget {
  const VoteResultPage({super.key, required this.result, this.player});

  final VoteResult result;
  final Player? player;

  @override
  State<VoteResultPage> createState() => _VoteResultPageState();
}

class _VoteResultPageState extends State<VoteResultPage> {
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
                    child: SvgPicture.asset(widget.result.getIconPath()),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  Text(
                    widget.result.getTitle(widget.player),
                    style: theme.textTheme.displaySmall,
                  ),

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
                        widget.result.getSubtitle(widget.player),
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
                      widget.result.getPhrase(widget.player),
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              Spacer(),

              _BeginNightTimerIndicator(onComplete: () {
                print('TIMER DONE!');
              }),

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

class _BeginNightTimerIndicator extends StatefulWidget {
  const _BeginNightTimerIndicator(
      {super.key, this.seconds = 5, required this.onComplete});

  final int seconds;
  final VoidCallback onComplete;

  @override
  State<_BeginNightTimerIndicator> createState() =>
      _BeginNightTimerIndicatorState();
}

class _BeginNightTimerIndicatorState extends State<_BeginNightTimerIndicator> {
  Timer? _timer;
  double _percent = 1;
  late int _remainingSeconds;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _percent = _remainingSeconds / widget.seconds;
        });
      } else {
        _timer!.cancel();
        await Future.delayed(const Duration(seconds: 1));
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('PROCEEDING TO NIGHT IN ${_remainingSeconds}S...', style: theme.textTheme.labelSmall),

        LinearPercentIndicator(
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 1000,
          restartAnimation: false,
          lineHeight: 10,
          barRadius: const Radius.circular(1000),
          padding: const EdgeInsets.all(0),
          backgroundColor: theme.colorScheme.onPrimary,
          progressColor: theme.colorScheme.onSecondary,
          percent: _percent,
        ),
      ],
    );
  }
}
