
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_event.dart';
import 'package:pocket_mafia/blocs/game_session/game_session_state.dart';

class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {

  GameSessionBloc() : super(const GameSessionState()) {
    on<GameAssignRoles>(_onGameAssignRoles);
    on<GameVillageVote>(_onGameVillageVote);
    on<GameMafiaKill>(_onGameMafiaKill);
    on<GameDetectiveInvestigate>(_onGameDoctorInvestigate);
    on<GameDoctorHeal>(_onGameDoctorHeal);
    on<GameVigilanteKill>(_onGameVigilanteKill);
    on<GameMafiaWin>(_onGameMafiaWin);
    on<GameVillageWin>(_onGameVillageWin);
    on<GameJesterWin>(_onGameJesterWin);
    on<GameHeadhunterWin>(_onGameHeadhunterWin);
    on<GameReset>(_onGameReset);
  }

  void _onGameAssignRoles(GameAssignRoles event, Emitter<GameSessionState> emit) {

  }

  void _onGameVillageVote(GameVillageVote event, Emitter<GameSessionState> emit) {

  }

  void _onGameMafiaKill(GameMafiaKill event, Emitter<GameSessionState> emit) {

  }

  void _onGameDoctorInvestigate(GameDetectiveInvestigate event, Emitter<GameSessionState> emit) {

  }

  void _onGameDoctorHeal(GameDoctorHeal event, Emitter<GameSessionState> emit) {

  }

  void _onGameVigilanteKill(GameVigilanteKill event, Emitter<GameSessionState> emit) {

  }

  void _onGameMafiaWin(GameMafiaWin event, Emitter<GameSessionState> emit) {

  }

  void _onGameVillageWin(GameVillageWin event, Emitter<GameSessionState> emit) {

  }

  void _onGameJesterWin(GameJesterWin event, Emitter<GameSessionState> emit) {

  }

  void _onGameHeadhunterWin(GameHeadhunterWin event, Emitter<GameSessionState> emit) {

  }

  void _onGameReset(GameReset event, Emitter<GameSessionState> emit) {

  }


}