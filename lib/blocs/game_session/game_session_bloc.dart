
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {

  GameSessionBloc() : super(const GameSessionState()) {
    on<GameAssignRoles>(_onAssignRoles);
    on<GameVillageVote>(_onVillageVote);
    on<GameMafiaKill>(_onMafiaKill);
    on<GameDetectiveInvestigate>(_onDoctorInvestigate);
    on<GameDoctorHeal>(_onDoctorHeal);
    on<GameVigilanteKill>(_onVigilanteKill);
    on<GameMafiaWin>(_onMafiaWin);
    on<GameVillageWin>(_onVillageWin);
    on<GameJesterWin>(_onJesterWin);
    on<GameHeadhunterWin>(_onHeadhunterWin);
    on<GameReset>(_onGameReset);
  }

  void _onAssignRoles(GameAssignRoles event, Emitter<GameSessionState> emit) {

  }

  void _onVillageVote(GameVillageVote event, Emitter<GameSessionState> emit) {

  }

  void _onMafiaKill(GameMafiaKill event, Emitter<GameSessionState> emit) {

  }

  void _onDoctorInvestigate(GameDetectiveInvestigate event, Emitter<GameSessionState> emit) {

  }

  void _onDoctorHeal(GameDoctorHeal event, Emitter<GameSessionState> emit) {

  }

  void _onVigilanteKill(GameVigilanteKill event, Emitter<GameSessionState> emit) {

  }

  void _onMafiaWin(GameMafiaWin event, Emitter<GameSessionState> emit) {

  }

  void _onVillageWin(GameVillageWin event, Emitter<GameSessionState> emit) {

  }

  void _onJesterWin(GameJesterWin event, Emitter<GameSessionState> emit) {

  }

  void _onHeadhunterWin(GameHeadhunterWin event, Emitter<GameSessionState> emit) {

  }

  void _onGameReset(GameReset event, Emitter<GameSessionState> emit) {

  }


}