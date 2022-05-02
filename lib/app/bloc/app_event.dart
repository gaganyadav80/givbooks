part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AppUserResetPassword extends AppEvent {
  const AppUserResetPassword(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
