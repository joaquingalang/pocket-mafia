import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class PhaseTimer extends StatefulWidget {
  const PhaseTimer({
    super.key,
    required this.duration,
    required this.onTimeout,
  });

  final Duration duration;
  final VoidCallback onTimeout;

  @override
  State<PhaseTimer> createState() => _PhaseTimerState();
}

class _PhaseTimerState extends State<PhaseTimer> {
  Timer? _secondsTimer;
  Timer? _timer;
  int _totalSeconds = 0;
  int _seconds = 0;

  void _startTimer() {
    _totalSeconds = widget.duration.inSeconds;
    _seconds = widget.duration.inSeconds;
    _secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds -= 1;
      });
    });
    _timer = Timer.periodic(widget.duration + Duration(seconds: 1), (timer) {
      widget.onTimeout();
      _timer!.cancel();
      _secondsTimer!.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _secondsTimer!.cancel();
    super.dispose();
  }

  String _formatDurationMMSS() {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircularPercentIndicator(
      radius: 20.w,
      lineWidth: 8,
      percent: _seconds / _totalSeconds,
      reverse: true,
      animation: true,
      animateFromLastPercent: true,
      animationDuration: 1000,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: theme.colorScheme.secondary,
      progressColor: theme.colorScheme.onSecondary,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatDurationMMSS(),
            style: theme.textTheme.headlineLarge!.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('REMAINING', style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}
