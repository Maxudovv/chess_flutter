import 'package:chess_frontend/repositories/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final Session _session;
  final String _startNewGameUrl = "/game/start";

  GameCubit({required Session session})
      : _session = session,
        super(GameState(
          status: GameStatus.pending,
          boardController: ChessBoardController(),
          gameId: "",
        ));

  Future<void> startNewGame() async {
    try {
      final response = await _session.client.post(
          _startNewGameUrl,
          data: {
            "colour": "white"
          }
      );
    } catch (error) {
      print("Suckaniggadick");
      print(error);
      print(_session.accessToken);
    }

    // emit(state.copyWith(
    //   status: GameStatus.inProgress,
    //   gameId: response.data["id"]!,
    // ));
  }
}
