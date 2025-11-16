part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserListLoading extends UserState {}

final class UserListLoadCompleted extends UserState {
  UserListLoadCompleted(this.users);
  final List<UserModel> users;
}

final class UserListLoadError extends UserState {
  UserListLoadError(this.error);
  final String? error;
}

final class UserCreateLoading extends UserState {}

final class UserCreateCompleted extends UserState {}

final class UserCreateError extends UserState {
  UserCreateError(this.error);
  final String? error;
}

final class UserUpdateLoading extends UserState {}

final class UserUpdateCompleted extends UserState {}

final class UserUpdateError extends UserState {
  UserUpdateError(this.error);
  final String? error;
}

final class UserDeleteLoading extends UserState {}

final class UserDeleteCompleted extends UserState {}

final class UserDeleteError extends UserState {
  UserDeleteError(this.error);
  final String? error;
}

final class UserDetailLoading extends UserState {}

final class UserDetailLoadCompleted extends UserState {
  UserDetailLoadCompleted(this.user);
  final UserModel user;
}

final class UserDetailLoadError extends UserState {
  UserDetailLoadError(this.error);
  final String? error;
}

final class ChangingPassword extends UserState {}

final class PasswordChanged extends UserState {}

final class PasswordChangeError extends UserState {
  PasswordChangeError(this.error);
  final String? error;
}


