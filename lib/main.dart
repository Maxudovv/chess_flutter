import 'package:chess_frontend/bloc/auth/auth_cubit.dart';
import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:chess_frontend/repositories/dio.dart';
import 'package:chess_frontend/repositories/rabbitmq.dart';
import 'package:chess_frontend/repositories/session.dart';
import 'package:chess_frontend/routes/router.dart';
import 'package:chess_frontend/screens/game/cubit/game_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    dio: await getDio(),
    sharedPreferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final Dio _dio;
  final SharedPreferences sharedPreferences;
  final _appRouter = AppRouter();

  MyApp({super.key, required Dio dio, required this.sharedPreferences})
      : _dio = dio;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(sharedPreferences: sharedPreferences),
      child: BlocProvider(
        create: (context) =>
        AuthCubit(authRepository: context.read<AuthRepository>())
          ..checkAuthState(),
        child: RepositoryProvider(
          create: (context) =>
              Session(
                dio: _dio,
                authRepository: context.read<AuthRepository>(),
              ),
          child: RepositoryProvider(
            create: (context) => WebSocketClient(),
            child: BlocProvider(
              create: (context) =>
                  GameCubit(
                    websocketClient: context.read<WebSocketClient>(),
                    session: context.read<Session>(),
                    // rabbitRepository: context.read<RabbitMQ>()
                  ),
              child: MaterialApp.router(
                routerConfig: _appRouter.config(),
                title: 'Труба Admin Panel',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
