// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:chess_frontend/screens/game/play_screen.dart' as _i3;
import 'package:chess_frontend/screens/game/start_new_game_screen.dart' as _i4;
import 'package:chess_frontend/screens/loading_screen.dart' as _i1;
import 'package:chess_frontend/screens/login/login_screen.dart' as _i2;

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i5.PageRouteInfo<void> {
  const LoadingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoadingScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.PlayScreen]
class PlayRoute extends _i5.PageRouteInfo<void> {
  const PlayRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PlayRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlayRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PlayScreen();
    },
  );
}

/// generated route for
/// [_i4.StartNewGameScreen]
class StartNewGameRoute extends _i5.PageRouteInfo<void> {
  const StartNewGameRoute({List<_i5.PageRouteInfo>? children})
      : super(
          StartNewGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartNewGameRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.StartNewGameScreen();
    },
  );
}
