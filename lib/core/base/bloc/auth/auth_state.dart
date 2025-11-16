part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, error }

class AuthState {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({UserModel? user})
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  AuthState.error({String? errorMessage}) : this._(status: AuthStatus.error, errorMessage: errorMessage);
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
}
