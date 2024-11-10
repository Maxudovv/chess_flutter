// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/screens/home_screen.dart';
import 'package:chess_frontend/screens/loading_screen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    // AutoRoute(
    //   initial: true,
    //   page: LoadingRoute.page,
    // ),
  ];
}
