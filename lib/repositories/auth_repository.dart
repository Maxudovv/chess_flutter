// Package imports:
import 'package:chess_frontend/repositories/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:

class AuthRepository {
  String? _sessionId;
  String? _csrfToken;
  final SharedPreferences _sharedPreferences;

  String get sessionId => _sessionId!;
  String get csrfToken => _csrfToken!;
  bool get isAuthenticated => _sessionId != null;

  AuthRepository(
      {required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  Future<void> login({
    required String login,
    required String password,
  }) async {
    final backendApi = await getDio();

    final response = await backendApi.post(
      "/user/login/",
      data: {
        "username": login,
        "password": password,
      },
    );
    final String cookie = response.headers["Set-Cookie"].toString();
    Map<String, String> cookieMap = Map.fromEntries(cookie.split(";").map((x) {
      final List<String> list = x.split("=");
      return MapEntry(list[0], list[1]);
    }));
    _sessionId = cookieMap["sessionId"] as String;
    _csrfToken = cookieMap["csrftoken"] as String;

    saveTokens();
  }

  void saveTokens() {
    _sharedPreferences.setString("sessionId", _sessionId!);
    _sharedPreferences.setString("csrfToken", _csrfToken!);
  }

  void loadTokens() {
    if (_sharedPreferences.containsKey("sessionId") &&
        _sharedPreferences.containsKey("csrfToken")) {
      _sessionId =_sharedPreferences.getString("sessionId")!;
      _csrfToken = _sharedPreferences.getString("csrfToken")!;
    }
  }
}
