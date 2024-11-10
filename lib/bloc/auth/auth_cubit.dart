// Flutter imports:
import 'package:chess_frontend/repositories/auth_repository.dart';
import 'package:chess_frontend/routes/guard.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository}) : _authRepository = authRepository, super(AuthInitial());

  Future<void> checkAuthState() async {
    await _authRepository.loadTokens();
    if (_authRepository.isAuthenticated) {
      emit(AuthAuthenticated());
      IsUserReady.setValue(true);
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
