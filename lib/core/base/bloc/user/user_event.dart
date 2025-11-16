part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class FetchAllUsers extends UserEvent {}

final class FetchUserById extends UserEvent {
  FetchUserById(this.id);
  final int id;
}

final class CreateUser extends UserEvent {
  CreateUser(this.user, this.image);
  final UpdateAndCreateUserModel user;
  final File? image;
}

final class UpdateUserForAdmin extends UserEvent {
  UpdateUserForAdmin(this.id, this.user, this.image);
  final int id;
  final UpdateAndCreateUserModel user;
  final File? image;
}

final class UpdateUser extends UserEvent {
  UpdateUser(this.id, this.user, this.image, this.context);
  final int id;
  final UpdateAndCreateUserModel user;
  final File? image;
  final BuildContext context;
}

final class DeleteUser extends UserEvent {
  DeleteUser(this.id);
  final int id;
}

final class FetchUserDetail extends UserEvent {
  FetchUserDetail(this.id);
  final int id;
}

final class ChangePassword extends UserEvent {
  ChangePassword(this.userId, this.oldPassword, this.newPassword);
  final int userId;
  final String oldPassword;
  final String newPassword;
}

final class FetchUsersByCity extends UserEvent {
  FetchUsersByCity(this.cityId);
  final int cityId;
}
