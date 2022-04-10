import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:givbooks/utils/utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void emailChanged(String value) {
    final isEmailValid = value.isEmail;

    emit(
      state.copyWith(
        email: value,
        status: isEmailValid ? FormzStatus.valid : FormzStatus.invalid,
      ),
    );
  }

  void passwordChanged(String value) {
    final isPasswordValid = value.length >= 6;

    emit(
      state.copyWith(
        password: value,
        confirmedPassword: state.confirmedPassword,
        status: isPasswordValid ? FormzStatus.valid : FormzStatus.invalid,
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final isConfirmedPassValid = value == state.password;

    emit(
      state.copyWith(
        confirmedPassword: value,
        status: isConfirmedPassValid ? FormzStatus.valid : FormzStatus.invalid,
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        name: state.name,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
