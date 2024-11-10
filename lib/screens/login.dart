import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_cubit.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Login'),
    //   ),
    //   body: BlocProvider(
    //     create: (context) => AuthCubit(),
    //     child: Center(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             // Логин
    //             TextField(
    //               controller: _loginController,
    //               decoration: InputDecoration(
    //                 labelText: 'Username',
    //                 border: OutlineInputBorder(),
    //               ),
    //             ),
    //             SizedBox(height: 16),
    //             // Пароль
    //             TextField(
    //               controller: _passwordController,
    //               decoration: InputDecoration(
    //                 labelText: 'Password',
    //                 border: OutlineInputBorder(),
    //               ),
    //               obscureText: true,
    //             ),
    //             SizedBox(height: 24),
    //             // Кнопка для авторизации
    //             ElevatedButton(
    //               onPressed: () {
    //                 final username = _loginController.text;
    //                 final password = _passwordController.text;
    //
    //                 // Вызываем метод login в Cubit
    //                 context.read<AuthCubit>().login(username, password);
    //               },
    //               child: Text('Login'),
    //             ),
    //             SizedBox(height: 16),
    //             // Показываем состояние авторизации
    //             BlocBuilder<AuthCubit, AuthState>(
    //               builder: (context, state) {
    //                 if (state is AuthLoading) {
    //                   return CircularProgressIndicator();
    //                 } else if (state is AuthSuccess) {
    //                   return Text('Login Successful: ${state.token}');
    //                 } else if (state is AuthError) {
    //                   return Text('Error: ${state.message}', style: TextStyle(color: Colors.red));
    //                 }
    //                 return Container(); // Пустой контейнер для начального состояния
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
