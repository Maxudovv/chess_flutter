// Package imports:
import 'package:chess_frontend/repositories/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:

class AuthRepository {
  String? _accessToken;
  String? _refreshToken;
  final SharedPreferences _sharedPreferences;

  String get accessToken => _accessToken!;
  bool get isAuthenticated => _accessToken != null;

  AuthRepository(
      {required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  Future<void> login({
    required String login,
    required String password,
  }) async {
    final backendApi = await getDio();

    final response = await backendApi.post(
      "/user/token/",
      data: {
        "username": login,
        "password": password,
      },
    );
    _accessToken = response.data["access"] as String;
    _refreshToken = response.data["refresh"] as String;

    saveTokens();
  }

  void saveTokens() {
    _sharedPreferences.setString("access", _accessToken!);
    _sharedPreferences.setString("refresh", _refreshToken!);
  }

  Future<void> loadTokens() async {
    if (_sharedPreferences.containsKey("access") &&
        _sharedPreferences.containsKey("refresh")) {
      _accessToken =_sharedPreferences.getString("access")!;
      _refreshToken = _sharedPreferences.getString("refresh")!;
    }
  }
}
