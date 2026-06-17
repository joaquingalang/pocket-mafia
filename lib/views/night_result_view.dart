import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/components/primary_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/utils/string_helpers.dart';
import 'package:sizer/sizer.dart';

class NightResultView extends StatefulWidget {
  const NightResultView({
    super.key,
    required this.deaths,
    required this.snitchSuspects,
    required this.onProceed,
  });

  final List<Player> deaths;
  final List<Player> snitchSuspects;
  final VoidCallback onProceed;

  @override
  State<NightResultView> createState() => _NightResultViewState();
}

class _NightResultViewState extends State<NightResultView> {
  bool _showMorticianReveal = false;
  bool _morticianRevealed = false;

  bool get _hasMortician {
    final state = context.read<GameSessionBloc>().state;
    return state.players.any((p) => p.role.type == Roles.mortician && !p.isDeceased);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_showMorticianReveal) {
      return _MorticianRevealStep(
        deaths: widget.deaths,
        isRevealed: _morticianRevealed,
        onReveal: () => setState(() => _morticianRevealed = true),
        onUnderstood: widget.onProceed,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('THE NIGHT FALLS', style: theme.textTheme.labelSmall),
                  Text(
                    'Dawn Has Arrived',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),

              const Spacer(),

              if (widget.deaths.isEmpty) ...[
                _QuietNightCard(),
              ] else ...[
                Column(
                  children: widget.deaths
                      .map((p) => _DeathCard(player: p))
                      .toList(),
                ),
              ],

              if (widget.snitchSuspects.isNotEmpty) ...[
                const SizedBox(height: 20),
                _SnitchRevealCard(suspects: widget.snitchSuspects),
              ],

              const Spacer(),

              _BeginDayTimerIndicator(
                onComplete: _hasMortician
                    ? () => setState(() => _showMorticianReveal = true)
                    : widget.onProceed,
              ),

              const SizedBox(height: 15),

              PrimaryButton(
                label: _hasMortician ? 'MORTICIAN REVEAL' : 'PROCEED TO DAY',
                iconData: _hasMortician ? Icons.manage_search : Icons.wb_sunny_outlined,
                onPressed: _hasMortician
                    ? () => setState(() => _showMorticianReveal = true)
                    : widget.onProceed,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuietNightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: SvgPicture.asset(
            'assets/images/icons/peace_icon.svg',
            width: 60,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        const SizedBox(height: 30),
        Text('A QUIET NIGHT', style: theme.textTheme.displaySmall),
        const SizedBox(height: 10),
        _Divider(label: 'NO BLOOD SPILLED'),
        const SizedBox(height: 20),
        SizedBox(
          width: 60.w,
          child: Text(
            'The village sleeps soundly. No one died tonight.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _DeathCard extends StatelessWidget {
  const _DeathCard({required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: SvgPicture.asset(
            'assets/images/icons/dead_icon.svg',
            width: 60,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        const SizedBox(height: 30),
        Text(player.name.toTitleCase(), style: theme.textTheme.displaySmall),
        const SizedBox(height: 10),
        _Divider(label: 'WAS KILLED TONIGHT'),
        const SizedBox(height: 20),
        SizedBox(
          width: 60.w,
          child: Text(
            'The night claimed another soul. ${player.name} is gone.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SnitchRevealCard extends StatelessWidget {
  const _SnitchRevealCard({required this.suspects});

  final List<Player> suspects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final names = suspects.map((p) => p.name).join(' & ');
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('THE SNITCH\'S LAST WORDS', style: theme.textTheme.labelSmall),
          const SizedBox(height: 6),
          Text(
            '"Keep an eye on $names..."',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 1, width: 46, color: theme.colorScheme.secondary),
        const SizedBox(width: 10),
        Text(
          label,
          style: theme.textTheme.labelSmall!.copyWith(color: theme.colorScheme.onSecondary),
        ),
        const SizedBox(width: 10),
        Container(height: 1, width: 46, color: theme.colorScheme.secondary),
      ],
    );
  }
}

class _MorticianRevealStep extends StatelessWidget {
  const _MorticianRevealStep({
    required this.deaths,
    required this.isRevealed,
    required this.onReveal,
    required this.onUnderstood,
  });

  final List<Player> deaths;
  final bool isRevealed;
  final VoidCallback onReveal;
  final VoidCallback onUnderstood;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('MORTICIAN', style: theme.textTheme.labelSmall),
                  Text('Pass To The Mortician', style: theme.textTheme.headlineSmall),
                ],
              ),
              const Spacer(),
              if (!isRevealed) ...[
                GestureDetector(
                  onTap: onReveal,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Icon(Icons.manage_search, color: theme.colorScheme.primary, size: 22.w),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'REVEAL',
                  style: theme.textTheme.headlineLarge!.copyWith(color: theme.colorScheme.onSecondary),
                ),
                const SizedBox(height: 10),
                Text('Tap to see who died and their role', style: theme.textTheme.labelMedium),
              ] else if (deaths.isEmpty) ...[
                Text('QUIET NIGHT', style: theme.textTheme.displaySmall),
                const SizedBox(height: 10),
                Text('No deaths to observe tonight.', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
              ] else ...[
                ...deaths.map((p) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(p.name.toTitleCase(), style: theme.textTheme.titleMedium),
                      Text(
                        'was a ${p.role.name ?? p.role.type.name.toTitleCase()}',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                )),
              ],
              const Spacer(),
              if (isRevealed || deaths.isEmpty)
                PrimaryButton(
                  label: 'UNDERSTOOD',
                  iconData: Icons.check,
                  onPressed: onUnderstood,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _BeginDayTimerIndicator extends StatefulWidget {
  const _BeginDayTimerIndicator({this.seconds = 5, required this.onComplete});

  final int seconds;
  final VoidCallback onComplete;

  @override
  State<_BeginDayTimerIndicator> createState() => _BeginDayTimerIndicatorState();
}

class _BeginDayTimerIndicatorState extends State<_BeginDayTimerIndicator> {
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
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PROCEEDING TO DAY IN ${_remainingSeconds}S...', style: theme.textTheme.labelSmall),
        const SizedBox(height: 8),
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
