import 'package:chess_frontend/bloc/auth/auth_cubit.dart';
import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:chess_frontend/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final AuthCubit _authCubit;

  LoginCubit({
    required AuthRepository authRepository,
    required AuthCubit authCubit,
  })  : _authRepository = authRepository,
        _authCubit = authCubit,
        super(
          LoginState(
              status: LoginStatus.initial,
              usernameController: TextEditingController(text: "admin"),
              passwordController: TextEditingController(text: "admin")),
        );

  Future<void> login() async {
    emit(state.copyWith(
      status: LoginStatus.loading,
    ));
    await _authRepository.login(
        login: state.usernameController.text,
        password: state.passwordController.text);
    _authCubit.checkAuthState();
    emit(state.copyWith(status: LoginStatus.success));
  }
}
