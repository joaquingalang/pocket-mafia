import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_event.dart';
import 'package:pocket_mafia/blocs/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<GameAddPlayer>(_onAddPlayer);
    on<GameRemovePlayer>(_onRemovePlayer);
    on<GameSetDayDuration>(_onSetDayDuration);
    on<GameSetVoteDuration>(_onSetVoteDuration);
    on<GameSetNightDuration>(_onSetNightDuration);
  }

  void _onAddPlayer(GameAddPlayer event, Emitter<GameState> emit) {
    emit(state.copyWith(names: [event.name, ...state.names]));
  }

  void _onRemovePlayer(GameRemovePlayer event, Emitter<GameState> emit) {
    emit(state.copyWith(names: List<String>.from(state.names)..removeAt(event.index)));
  }

  void _onSetDayDuration(GameSetDayDuration event, Emitter<GameState> emit) {
    emit(state.copyWith(dayDuration: event.duration));
  }

  void _onSetVoteDuration(GameSetVoteDuration event, Emitter<GameState> emit) {
    emit(state.copyWith(voteDuration: event.duration));
  }

  void _onSetNightDuration(GameSetNightDuration event, Emitter<GameState> emit) {
    emit(state.copyWith(nightDuration: event.duration));
  }

}