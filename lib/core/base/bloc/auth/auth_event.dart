part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {}

class LogoutRequested extends AuthEvent {
  LogoutRequested();
}

class LoginRequested extends AuthEvent {
  LoginRequested({required this.phone, required this.password});
  final String phone;
  final String password;
}

class DeleteAccount extends AuthEvent {}

class UpdateGlobalBlocUser extends AuthEvent {
  UpdateGlobalBlocUser(this.context);
  final BuildContext context;
}
