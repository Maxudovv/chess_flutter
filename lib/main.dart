import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:chess_frontend/repositories/dio.dart';
import 'package:chess_frontend/routes/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    dio: await getDio(),
    sharedPreferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final Dio _dio;
  final SharedPreferences sharedPreferences;
  final _appRouter = AppRouter();

  MyApp({super.key, required Dio dio, required this.sharedPreferences}) : _dio = dio;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(sharedPreferences: sharedPreferences),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Труба Admin Panel',
      ),
    );
  }
}
