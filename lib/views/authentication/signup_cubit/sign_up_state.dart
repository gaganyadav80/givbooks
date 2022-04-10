part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmedPassword = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final String name;
  final String email;
  final String password;
  final String confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [name, email, password, confirmedPassword, status];

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
