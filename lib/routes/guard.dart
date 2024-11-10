// Dart imports:
import 'dart:async';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/routes/router.gr.dart';
import 'package:chess_frontend/screens/loading_screen.dart';

// Project imports:

class UserReadyGuard extends AutoRouteGuard {
  bool get isUserReady => IsUserReady.getValue();

  bool isLoginRoute(RouteMatch route) {
    return route.name == "LoginRoute" || route.name == "LoadingRoute";
  }

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (isLoginRoute(resolver.route)) {
      if (isUserReady) {
        resolver.redirect(const StartNewGameRoute());
      } else {
        resolver.next();
      }
    } else {
      if (isUserReady) {
        resolver.next();
      } else {
        resolver.redirect(
          LoadingRoute(
            onUserReady: () {
              resolver.next();
              router.removeLast();
            },
          ),
        );
      }
    }
  }
}

class IsUserReady {
  static bool _value = false;

  IsUserReady._();

  static bool getValue() {
    return _value;
  }

  static void setValue(bool newValue) {
    _value = newValue;
  }
}
