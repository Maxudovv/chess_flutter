import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/bloc/auth/auth_cubit.dart';
import 'package:chess_frontend/routes/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoadingScreen extends StatelessWidget {

  const LoadingScreen({super.key});

  Future<void> listen(BuildContext context, AuthState state) async {
    if (state is AuthAuthenticated) {
      context.router.replaceNamed("/game");
    } else if (state is AuthUnauthenticated) {
      context.router.replaceNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => listen(context, state),
        builder: (context, state) {
          listen(context, state);
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

