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
  final List<String> _moves;
  final bool _colour;
  final String _previousFen;
  final String _finishText;

  List<String> get moves => _moves;

  GameStatus get status => _status;

  ChessBoardController get boardController => _boardController;

  String get gameId => _gameId;

  bool get colour => _colour;

  String get previousFen => _previousFen;

  String get finishText => _finishText;

  GameState({
    required GameStatus status,
    required ChessBoardController boardController,
    required String gameId,
    required bool colour,
    String? previousFen,
    List<String>? moves,
    String? finishText,
  })  : _status = status,
        _boardController = boardController,
        _gameId = gameId,
        _moves = moves ?? [],
        _colour = colour,
        _previousFen = previousFen ?? "",
        _finishText = finishText ?? "";

  GameState copyWith({
    GameStatus? status,
    ChessBoardController? boardController,
    String? gameId,
    List<String>? moves,
    bool? colour,
    String? previousFen,
    String? finishText,
  }) =>
      GameState(
        status: status ?? _status,
        boardController: boardController ?? _boardController,
        gameId: gameId ?? _gameId,
        moves: moves ?? _moves,
        colour: colour ?? _colour,
        previousFen: previousFen ?? _previousFen,
        finishText: finishText ?? _finishText
      );
}
