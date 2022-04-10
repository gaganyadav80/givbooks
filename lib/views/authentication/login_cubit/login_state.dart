part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final String email;
  final String password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    String? email,
    String? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
