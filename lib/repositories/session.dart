// Package imports:
import 'package:dio/dio.dart';

class Session {
  final Dio _client;
  final String _sessionId;
  final String _csrfToken;

  Dio get client => _client;

  Session(
      {required Dio dio, required String sessionId, required String csrfToken})
      : _client = dio,
        _sessionId = sessionId,
        _csrfToken = csrfToken {
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Cookie"] = "sessionId=$_sessionId;csrftoken=$_csrfToken";
          return handler.next(options);
        },
      ),
    );
  }
}
