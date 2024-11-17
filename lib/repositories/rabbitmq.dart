import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  final String login = "chess"; // Ваш логин
  final String password = "chess"; // Ваш пароль

  final WebSocketChannel _channel;

  WebSocketChannel get channel => _channel;

  final String stompConnectHeaders = """
CONNECT
accept-version:1.2
host:/
login:chess
passcode:chess
heart-beat:0,0

\x00
""";

  WebSocketClient()
      : _channel =
            WebSocketChannel.connect(Uri.parse("ws://localhost:15674/ws")) {
    _channel.sink.add(stompConnectHeaders);
  }

  void setSubscribeHeaders(String gameId) {
    final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    final stompSubscribeHeaders = """
SUBSCRIBE
id:$uniqueId
destination:/queue/game_$gameId
ack:auto

\x00
""";
    // print("Подписка на $gameId...");
    _channel.sink.add(stompSubscribeHeaders);
  }
}
