import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/theme.dart';

class GameSetupPage extends StatefulWidget {
  const GameSetupPage({super.key});

  @override
  State<GameSetupPage> createState() => _GameSetupPageState();
}

class _GameSetupPageState extends State<GameSetupPage> {
  double _dayDuration = 300;
  final double _dayMin = 30;
  final double _dayMax = 600;
  final int _dayDivisions = 19;

  double _nightDuration = 60;
  final double _nightMin = 15;
  final double _nightMax = 180;
  final int _nightDivisions = 11;

  double _voteDuration = 30;
  final double _voteMin = 10;
  final double _voteMax = 60;
  final int _voteDivision = 5;

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
              MainAppBar(label: 'Game Setup'),

              // Offset
              SizedBox(height: 35),

              Text('PHASE DURATION (SEC)', style: theme.textTheme.labelSmall),

              // Offset
              SizedBox(height: 12),

              PhaseDurationSlider(
                phase: Phase.day,
                min: _dayMin,
                max: _dayMax,
                divisions: _dayDivisions,
                duration: _dayDuration,
                onChanged: (value) {
                  setState(() {
                    _dayDuration = value;
                  });
                },
              ),

              // Offset
              SizedBox(height: 16),

              PhaseDurationSlider(
                phase: Phase.night,
                min: _nightMin,
                max: _nightMax,
                divisions: _nightDivisions,
                duration: _nightDuration,
                onChanged: (value) {
                  setState(() {
                    _nightDuration = value;
                  });
                },
              ),

              // Offset
              SizedBox(height: 16),

              PhaseDurationSlider(
                phase: Phase.vote,
                min: _voteMin,
                max: _voteMax,
                divisions: _voteDivision,
                duration: _voteDuration,
                onChanged: (value) {
                  setState(() {
                    _voteDuration = value;
                  });
                },
              ),

              Spacer(),

              RoundedRectangleButton(
                label: 'ADD PLAYERS',
                iconData: Icons.arrow_forward,
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

class PhaseDurationSlider extends StatefulWidget {
  const PhaseDurationSlider({
    super.key,
    required this.phase,
    required this.duration,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final Phase phase;
  final double duration;
  final double min;
  final double max;
  final int divisions;
  final Function(double)? onChanged;

  @override
  State<PhaseDurationSlider> createState() => _PhaseDurationSliderState();
}

class _PhaseDurationSliderState extends State<PhaseDurationSlider> {
  late final String _phaseLabel;
  late final String _icon;

  void _initPhaseMetrics() {
    switch (widget.phase) {
      case Phase.day:
        setState(() {
          _phaseLabel = 'Day Duration';
          _icon = 'sun';
        });
        break;
      case Phase.night:
        setState(() {
          _phaseLabel = 'Night Duration / Role';
          _icon = 'moon';
        });
        break;
      case Phase.vote:
        setState(() {
          _phaseLabel = 'Vote Duration / Player';
          _icon = 'gavel';
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _initPhaseMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Label
          Row(
            spacing: 10,
            children: [
              SvgPicture.asset('assets/images/icons/${_icon}_icon.svg'),
              Text(_phaseLabel, style: theme.textTheme.titleSmall),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSecondary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.duration.toInt()}s',
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),

          // Offset
          SizedBox(height: 20),

          // Slider
          Slider(
            padding: EdgeInsets.symmetric(horizontal: 2),
            inactiveColor: const Color(0xFF4E5F79),
            activeColor: const Color(0xFF4E5F79),
            thumbColor: theme.colorScheme.onSecondary,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            value: widget.duration,
            onChanged: widget.onChanged,
          ),

          // Offset
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.min.toInt()}S',
                style: theme.textTheme.labelMedium,
              ),
              Text(
                '${(widget.max / 60).toInt()}M',
                style: theme.textTheme.labelMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
