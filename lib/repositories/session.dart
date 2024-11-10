// Package imports:
import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class Session {
  final Dio _client;
  final AuthRepository _authRepository;

  String get accessToken => _authRepository.accessToken;

  Dio get client => _client;

  Session({required Dio dio, required AuthRepository authRepository})
      : _client = dio,
        _authRepository = authRepository {
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] = "Bearer $accessToken";
          return handler.next(options);
        },
      ),
    );
  }
}
