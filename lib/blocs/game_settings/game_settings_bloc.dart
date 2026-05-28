import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_settings/game_settings_event.dart';
import 'package:pocket_mafia/blocs/game_settings/game_settings_state.dart';
import 'package:pocket_mafia/enums/roles.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  GameSettingsBloc() : super(const GameSettingsState()) {
    on<GameSettingsAddPlayer>(_onAddPlayer);
    on<GameSettingsRemovePlayer>(_onRemovePlayer);
    on<GameSettingsSetDayDuration>(_onSetDayDuration);
    on<GameSettingsSetVoteDuration>(_onSetVoteDuration);
    on<GameSettingsSetNightDuration>(_onSetNightDuration);
    on<GameSettingsAddRole>(_onAddRole);
    on<GameSettingsRemoveRole>(_onRemoveRole);
  }

  void _onAddPlayer(GameSettingsAddPlayer event,
      Emitter<GameSettingsState> emit) {
    emit(state.copyWith(names: [event.name, ...state.names]));
  }

  void _onRemovePlayer(GameSettingsRemovePlayer event,
      Emitter<GameSettingsState> emit) {
    emit(state.copyWith(names: List<String>.from(state.names)
      ..removeAt(event.index)));
  }

  void _onSetDayDuration(GameSettingsSetDayDuration event,
      Emitter<GameSettingsState> emit) {
    emit(state.copyWith(dayDuration: event.duration));
  }

  void _onSetVoteDuration(GameSettingsSetVoteDuration event,
      Emitter<GameSettingsState> emit) {
    emit(state.copyWith(voteDuration: event.duration));
  }

  void _onSetNightDuration(GameSettingsSetNightDuration event,
      Emitter<GameSettingsState> emit) {
    emit(state.copyWith(nightDuration: event.duration));
  }

  void _onAddRole(GameSettingsAddRole event, Emitter<GameSettingsState> emit) {
    emit(state.copyWith(roles: [...state.roles, event.role]));
  }

  void _onRemoveRole(GameSettingsRemoveRole event,
      Emitter<GameSettingsState> emit) {
    List<Roles> deleted = List<Roles>.from(state.roles);
    for (int i = 0; i < deleted.length; i++) {
      if (deleted[i] == event.role) {
        deleted.removeAt(i);
        break;
      }
    }
    emit(state.copyWith(roles: deleted));
  }

}