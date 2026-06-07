import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';
import 'package:pocket_mafia/enums/phase.dart';
import 'package:pocket_mafia/enums/vote_result.dart';
import 'package:pocket_mafia/models/game_settings.dart';
import 'package:pocket_mafia/models/player.dart';
import 'package:pocket_mafia/views/day_view.dart';
import 'package:pocket_mafia/views/night_view.dart';
import 'package:pocket_mafia/views/vote_result_view.dart';
import 'package:pocket_mafia/views/voting_view.dart';

class GameSessionPage extends StatefulWidget {
  const GameSessionPage({super.key});

  @override
  State<GameSessionPage> createState() => _GameSessionPageState();
}

class _GameSessionPageState extends State<GameSessionPage> {

  Widget getPhaseView(GameSessionState state) {
    switch (state.phase) {
      case Phase.day:
        return DayView(
          round: state.round,
          duration: state.dayDuration,
          players: state.players,
          onPhaseChange: () {
            final bloc = context.read<GameSessionBloc>();
            bloc.add(const GameBuildVoteMap());
            bloc.add(const GameSetPhase(phase: Phase.voting));
          },
        );
      case Phase.night:
        return NightView(
          round: state.round,
          duration: state.nightDuration,
          players: state.players,
          onPhaseChange: () => context.read<GameSessionBloc>().add(GameSetPhase(phase: Phase.day)),
        );
      case Phase.voting:
        return VotingView(
          round: state.round,
          duration: state.voteDuration,
          players: state.players,
          onPhaseChange: () {},
        );
      case Phase.voteResult:
        return VoteResultPage(
          result: state.voteResult ?? VoteResult.spared,
          player: state.eliminatedPlayer,
          onProceed: () => context.read<GameSessionBloc>().add(
            const GameSetPhase(phase: Phase.night),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameSessionBloc, GameSessionState>(
        builder: (context, state) {
          return getPhaseView(state);
        }
      ),
    );
  }
}
