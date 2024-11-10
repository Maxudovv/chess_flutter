import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:chess_frontend/screens/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(authRepository: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>()),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              context.router.replaceNamed("/game");
            }
          },
          listenWhen: (oldState, newState) =>
          oldState.status != newState.status,
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Логин
                    TextField(
                      controller: state.usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Пароль
                    TextField(
                      controller: state.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 24),
                    // Кнопка для авторизации
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login();
                      },
                      child: Text('Login'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
