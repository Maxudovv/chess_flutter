import 'dart:async';
import 'dart:convert';


import 'package:chess_frontend/repositories/rabbitmq.dart';
import 'package:chess_frontend/repositories/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final Session _session;
  final String _startNewGameUrl = "/game/start";
  final WebSocketClient _websocketClient;
  late StreamSubscription _subscription;

  GameCubit(
      {required Session session, required WebSocketClient websocketClient})
      : _session = session,
        _websocketClient = websocketClient,
        super(GameState(
          status: GameStatus.pending,
          boardController: ChessBoardController(),
          gameId: "",
        ));

  Future<void> startNewGame() async {
    final response =
        await _session.client.post(_startNewGameUrl, data: {"colour": "black"});

    final gameId = response.data["id"]!;

    _websocketClient.setSubscribeHeaders(gameId);
    _subscription = _websocketClient.channel.stream.listen(
          (message) {
        processNewMessage(message);
      },
      onError: (error) {
        print("Ошибка: $error");
      },
      onDone: () {
        print("Соединение закрыто");
      },
    );

    emit(state.copyWith(
      status: GameStatus.inProgress,
      gameId: gameId,
    ));
  }

  void processNewMessage(dynamic message) {
    print("NEW MESSAGE");
    final parts = message.split("\n\n");

    if (parts.length < 2) {
      print("Некорректное сообщение");
    }

    final body = parts[1].trim().replaceAll("\x00", "");
    if (body == "") {
      return;
    }
    final json = jsonDecode(body);
    print(json);
    performEngineMove(json["text"]);
  }

  void performEngineMove(String moveUci) {
    final from = moveUci.substring(0, 2);
    final to = moveUci.substring(2);
    state.boardController.makeMove(from: from, to: to);
    emit(state.copyWith(boardController: state.boardController));
  }
}
