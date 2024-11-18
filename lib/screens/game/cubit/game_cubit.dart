import 'dart:async';
import 'dart:convert';

import 'package:chess_frontend/repositories/rabbitmq.dart';
import 'package:chess_frontend/repositories/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final Session _session;
  final String _startNewGameUrl = "/game/start";
  final String _makeMoveUrl = "/game/make_move";
  final WebSocketClient _websocketClient;

  GameCubit(
      {required Session session, required WebSocketClient websocketClient})
      : _session = session,
        _websocketClient = websocketClient,
        super(GameState(
          status: GameStatus.pending,
          boardController: ChessBoardController(),
          gameId: "",
          colour: true,
        previousFen: ChessBoardController().getFen()
        )) {
    state.boardController.addListener(onBoardChange);
  }

  void _connectWebsocket(String gameId) {
    _websocketClient.setSubscribeHeaders(gameId);
    _websocketClient.channel.stream.listen(
          (message) {
        processNewMessage(message);
      },
      onError: (error) {
        print("Ошибка: $error");
      },
      onDone: () {
        _connectWebsocket(gameId);
      },
    );
  }

  Future<void> startNewGame() async {
    const colour = "black";

    final response =
        await _session.client.post(_startNewGameUrl, data: {"colour": colour});


    final gameId = response.data["id"]!;
    print(gameId);
    _connectWebsocket(gameId);


    emit(state.copyWith(
      status: GameStatus.inProgress,
      gameId: gameId,
      colour: colour == "white"
    ));
  }

  Future<void> onBoardChange() async {
    final userColour = state.colour ? Chess.WHITE : Chess.BLACK;
    if (state.boardController.game.turn == userColour || state.previousFen == state.boardController.getFen()) {
      return;
    }

    final lastMoveUci = _getLastMove();
    await sendMove(lastMoveUci);

    emit(state.copyWith(
      previousFen: state.boardController.getFen()
    ));
  }

  String _getLastMove() {
    final lastMove = state.boardController.game.history.last.move;
    return Chess.algebraic(lastMove.from) + Chess.algebraic(lastMove.to);
  }

  Future<void> sendMove(String moveUci) async {
    final response = _session.client.post(_makeMoveUrl, data: {
      "game": state.gameId,
      "text": moveUci
    });
  }

  void processNewMessage(dynamic message) {
    final parts = message.split("\n\n");

    if (parts.length < 2) {
      print("Некорректное сообщение");
      return;
    }

    final body = parts[1].trim().replaceAll("\x00", "");
    if (body == "") {
      return;
    }
    final json = jsonDecode(body);
    if (json["type"] == "move") {
      performEngineMove(json["text"]);
    } else if (json["type"] == "finish") {
      performGameFinish(json["text"]);
    }
  }

  void performEngineMove(String moveUci) {
    final from = moveUci.substring(0, 2);
    final to = moveUci.substring(2);
    final moves = state.moves;
    moves.add(moveUci);
    print(moveUci);
    emit(state.copyWith(moves: moves));
    state.boardController.makeMove(from: from, to: to);
  }

  void performGameFinish(String text) {
    emit(state.copyWith(
      status: GameStatus.finished,
      finishText: text
    ));
  }
}
