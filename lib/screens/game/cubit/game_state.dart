part of 'game_cubit.dart';

enum GameStatus {
  pending,
  started,
  inProgress,
  finished,
  error,
}

@immutable
class GameState {
  final GameStatus _status;
  final ChessBoardController _boardController;
  final String _gameId;

  GameStatus get status => _status;
  ChessBoardController get boardController => _boardController;
  String get gameId => _gameId;

  const GameState({
    required GameStatus status,
    required ChessBoardController boardController,
    required String gameId,
  })  : _status = status,
        _boardController = boardController,
        _gameId = gameId;

  GameState copyWith({
    GameStatus? status,
    ChessBoardController? boardController,
    String? gameId,
  }) =>
      GameState(
        status: status ?? _status,
        boardController: boardController ?? _boardController,
        gameId: gameId ?? _gameId,
      );

}
