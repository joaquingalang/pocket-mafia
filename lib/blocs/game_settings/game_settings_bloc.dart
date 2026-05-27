import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_settings/GameSettingsEvent.dart';
import 'package:pocket_mafia/blocs/game_settings/game_settings_state.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  GameSettingsBloc() : super(const GameSettingsState()) {
    on<GameAddPlayer>(_onAddPlayer);
    on<GameRemovePlayer>(_onRemovePlayer);
    on<GameSetDayDuration>(_onSetDayDuration);
    on<GameSetVoteDuration>(_onSetVoteDuration);
    on<GameSetNightDuration>(_onSetNightDuration);
  }

  void _onAddPlayer(GameAddPlayer event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(names: [event.name, ...state.names]));
  }

  void _onRemovePlayer(GameRemovePlayer event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(names: List<String>.from(state.names)..removeAt(event.index)));
  }

  void _onSetDayDuration(GameSetDayDuration event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(dayDuration: event.duration));
  }

  void _onSetVoteDuration(GameSetVoteDuration event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(voteDuration: event.duration));
  }

  void _onSetNightDuration(GameSetNightDuration event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(nightDuration: event.duration));
  }

}