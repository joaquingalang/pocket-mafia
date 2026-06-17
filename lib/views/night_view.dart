import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/components/game_app_bar.dart';
import 'package:pocket_mafia/components/phase_button.dart';
import 'package:pocket_mafia/components/phase_timer.dart';
import 'package:pocket_mafia/components/player_select_tile.dart';
import 'package:pocket_mafia/components/primary_button.dart';
import 'package:pocket_mafia/enums/roles.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:sizer/sizer.dart';

enum _SubPhase { hidden, action, detectiveResult }

class _NightStep {
  final Roles role;
  final Player actor;
  const _NightStep(this.role, this.actor);
}

class NightView extends StatefulWidget {
  const NightView({
    super.key,
    required this.round,
    required this.duration,
    required this.players,
    required this.onPhaseChange,
  });

  final int round;
  final Duration duration;
  final List<Player> players;
  final VoidCallback onPhaseChange;

  @override
  State<NightView> createState() => _NightViewState();
}

class _NightViewState extends State<NightView> {
  late List<_NightStep> _queue;
  int _stepIndex = 0;
  _SubPhase _subPhase = _SubPhase.hidden;
  Player? _selectedPlayer;
  Teams? _detectiveResultTeam;

  static const _roleOrder = [
    Roles.mafia,
    Roles.detective,
    Roles.doctor,
    Roles.vigilante,
    Roles.preacher,
    Roles.medium,
  ];

  @override
  void initState() {
    super.initState();
    _buildQueue(context.read<GameSessionBloc>().state);
  }

  void _buildQueue(GameSessionState state) {
    final alive = widget.players.where((p) => !p.isDeceased).toList();
    final queue = <_NightStep>[];

    for (final role in _roleOrder) {
      if (role == Roles.vigilante && state.vigilanteHasKilled) continue;
      if (role == Roles.medium && state.mediumHasRevived) continue;

      final actor = alive.where((p) => p.role.type == role).firstOrNull;
      if (actor != null) queue.add(_NightStep(role, actor));
    }

    _queue = queue;
  }

  List<Player> get _alivePlayers =>
      widget.players.where((p) => !p.isDeceased).toList();

  List<Player> get _deadPlayers =>
      widget.players.where((p) => p.isDeceased).toList();

  List<Player> _targetsForRole(Roles role) {
    final alive = _alivePlayers;
    if (role == Roles.mafia) {
      return alive.where((p) => p.role.type != Roles.mafia).toList();
    }
    if (role == Roles.medium) return _deadPlayers;
    return alive;
  }

  bool _canSkip(Roles role) =>
      role == Roles.vigilante || role == Roles.medium || role == Roles.preacher;

  void _onReveal() => setState(() => _subPhase = _SubPhase.action);

  void _onConfirm() {
    if (_selectedPlayer == null) return;
    final step = _queue[_stepIndex];
    final bloc = context.read<GameSessionBloc>();
    final idx = widget.players.indexOf(_selectedPlayer!);

    switch (step.role) {
      case Roles.mafia:
        bloc.add(GameMafiaKill(index: idx));
        _advance();
      case Roles.detective:
        bloc.add(GameDetectiveInvestigate(index: idx));
        // Compute result locally to avoid async timing issues
        setState(() {
          _detectiveResultTeam = _selectedPlayer!.role.team;
          _subPhase = _SubPhase.detectiveResult;
        });
      case Roles.doctor:
        bloc.add(GameDoctorHeal(index: idx));
        _advance();
      case Roles.vigilante:
        bloc.add(GameVigilanteKill(index: idx));
        _advance();
      case Roles.preacher:
        bloc.add(GamePreacherGuess(index: idx));
        _advance();
      case Roles.medium:
        bloc.add(GameMediumRevive(index: idx));
        _advance();
      default:
        _advance();
    }
  }

  void _onSkip() => _advance();

  void _onDetectiveUnderstood() => _advance();

  void _advance() {
    if (_stepIndex + 1 >= _queue.length) {
      context.read<GameSessionBloc>().add(const GameResolveNight());
      widget.onPhaseChange();
    } else {
      setState(() {
        _stepIndex++;
        _subPhase = _SubPhase.hidden;
        _selectedPlayer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_queue.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GameSessionBloc>().add(const GameResolveNight());
        widget.onPhaseChange();
      });
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final step = _queue[_stepIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GameAppBar(
                title: 'Night Action',
                subtitle: 'NIGHT ${widget.round}',
                onClose: () {},
                onInfo: () {},
              ),
              const SizedBox(height: 20),
              PhaseTimer(duration: widget.duration, onTimeout: () {}),
              const SizedBox(height: 20),
              Expanded(
                child: _subPhase == _SubPhase.hidden
                    ? _HiddenStep(actor: step.actor, onReveal: _onReveal)
                    : _subPhase == _SubPhase.detectiveResult
                        ? _DetectiveResultStep(result: _detectiveResultTeam, onUnderstood: _onDetectiveUnderstood)
                        : _ActionStep(
                            step: step,
                            players: widget.players,
                            targets: _targetsForRole(step.role),
                            selected: _selectedPlayer,
                            canSkip: _canSkip(step.role),
                            onSelect: (p) => setState(() => _selectedPlayer = p),
                            onConfirm: _onConfirm,
                            onSkip: _onSkip,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Sub-widgets ---

class _HiddenStep extends StatelessWidget {
  const _HiddenStep({required this.actor, required this.onReveal});

  final Player actor;
  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onReveal,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(1000),
              boxShadow: [
                BoxShadow(blurRadius: 20, color: theme.colorScheme.onSecondary.withOpacity(0.25)),
                BoxShadow(blurRadius: 100, color: theme.colorScheme.onSecondary.withOpacity(0.50)),
              ],
            ),
            child: Icon(Icons.nightlight_round, color: theme.colorScheme.primary, size: 22.w),
          ),
        ),
        const SizedBox(height: 15),
        Text('PASS DEVICE', style: theme.textTheme.headlineLarge!.copyWith(color: theme.colorScheme.onSecondary)),
        const SizedBox(height: 10),
        Text('Pass to ${actor.name}', style: theme.textTheme.labelMedium),
        const SizedBox(height: 6),
        Text('Tap to reveal your role action', style: theme.textTheme.labelSmall),
      ],
    );
  }
}

class _ActionStep extends StatelessWidget {
  const _ActionStep({
    required this.step,
    required this.players,
    required this.targets,
    required this.selected,
    required this.canSkip,
    required this.onSelect,
    required this.onConfirm,
    required this.onSkip,
  });

  final _NightStep step;
  final List<Player> players;
  final List<Player> targets;
  final Player? selected;
  final bool canSkip;
  final ValueChanged<Player?> onSelect;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;

  String get _title => switch (step.role) {
        Roles.mafia => 'MAFIA',
        Roles.detective => 'DETECTIVE',
        Roles.doctor => 'DOCTOR',
        Roles.vigilante => 'VIGILANTE',
        Roles.preacher => 'PREACHER',
        Roles.medium => 'MEDIUM',
        _ => step.role.name.toUpperCase(),
      };

  String get _instruction => switch (step.role) {
        Roles.mafia => 'CHOOSE YOUR VICTIM',
        Roles.detective => 'INVESTIGATE A PLAYER',
        Roles.doctor => 'CHOOSE A PLAYER TO PROTECT',
        Roles.vigilante => 'USE YOUR ABILITY OR SKIP',
        Roles.preacher => 'GUESS WHO WILL DIE TONIGHT',
        Roles.medium => 'CHOOSE A PLAYER TO REVIVE',
        _ => 'TAKE YOUR ACTION',
      };

  String get _listLabel => step.role == Roles.medium
      ? 'SELECT A PLAYER TO REVIVE'
      : 'SELECT A PLAYER';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(_title, style: theme.textTheme.headlineSmall),
              Text(_instruction, style: theme.textTheme.labelSmall),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(_listLabel, style: theme.textTheme.labelSmall),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: targets.length,
            itemBuilder: (context, index) {
              final player = targets[index];
              return PlayerSelectTile(
                name: player.name,
                id: players.indexOf(player) + 1,
                value: player == selected,
                onChanged: (checked) => onSelect(checked == true ? player : null),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          spacing: 12,
          children: [
            if (canSkip)
              PhaseButton(
                label: 'SKIP',
                isPrimary: false,
                trailing: SvgPicture.asset(
                  'assets/images/icons/peace_icon.svg',
                  width: 18,
                  color: theme.colorScheme.onTertiary,
                ),
                onPressed: onSkip,
              ),
            PhaseButton(
              label: 'CONFIRM',
              trailing: SvgPicture.asset(
                'assets/images/icons/check_circle_icon.svg',
                width: 18,
                color: theme.colorScheme.primary,
              ),
              onPressed: selected != null ? onConfirm : () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _DetectiveResultStep extends StatelessWidget {
  const _DetectiveResultStep({required this.result, required this.onUnderstood});

  final Teams? result;
  final VoidCallback onUnderstood;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = result?.name.toUpperCase() ?? '???';
    final isKiller = result == Teams.killer;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: isKiller ? Colors.red.shade900 : Colors.blue.shade900,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Icon(
            isKiller ? Icons.warning_rounded : Icons.verified_user,
            color: Colors.white,
            size: 22.w,
          ),
        ),
        const SizedBox(height: 20),
        Text('TEAM', style: theme.textTheme.labelSmall),
        Text(label, style: theme.textTheme.displaySmall),
        const SizedBox(height: 10),
        Text(
          isKiller ? 'This player is on the Mafia\'s side.' : 'This player is on the Village\'s side.',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        PrimaryButton(
          label: 'UNDERSTOOD',
          iconData: Icons.check,
          onPressed: onUnderstood,
        ),
      ],
    );
  }
}
