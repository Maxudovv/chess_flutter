part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  error,
  success,
  loading,
}

@immutable
class LoginState {
  final LoginStatus status;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginState({
    required this.status,
    required this.usernameController,
    required this.passwordController,
  });

  LoginState copyWith({
    LoginStatus? status,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      status: status ?? this.status,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
