// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/routes/guard.dart';
import 'package:chess_frontend/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      initial: true,
      page: LoadingRoute.page,
      guards: [UserReadyGuard()],
    ),
    AutoRoute(
      path: "/login",
      page: LoginRoute.page,
      guards: [UserReadyGuard()],
    ),
    AutoRoute(
      path: "/game",
      page: StartNewGameRoute.page,
      guards: [UserReadyGuard()],
    ),
    AutoRoute(
      path: "/play",
      page: PlayRoute.page,
      guards: [UserReadyGuard()],
    ),
  ];
}
