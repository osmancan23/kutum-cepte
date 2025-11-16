import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/update_and_create_user_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/base/service/firebase/firebase_storage_service.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._userService) : super(UserInitial()) {
    on<FetchAllUsers>(_fetchAllUsers);
    on<FetchUserById>(_fetchUserById);
    on<CreateUser>(_createUser);
    on<UpdateUserForAdmin>(_updateUserForAdmin);
    on<UpdateUser>(_updateUser);
    on<DeleteUser>(_deleteUser);
    on<ChangePassword>(_changePassword);
    on<FetchUsersByCity>(_fetchUsersByCity);
  }
  final IUserService _userService;

  Future<void> _fetchAllUsers(FetchAllUsers event, Emitter<UserState> emit) async {
    emit(UserListLoading());
    try {
      final users = await _userService.fetchAllUsers();
      emit(UserListLoadCompleted(users));
    } catch (e) {
      emit(UserListLoadError(e.toString()));
    }
  }

  Future<void> _fetchUserById(FetchUserById event, Emitter<UserState> emit) async {
    emit(UserDetailLoading());
    try {
      final user = await _userService.fetchUserById(event.id);
      emit(UserDetailLoadCompleted(user!));
    } catch (e) {
      emit(UserDetailLoadError(e.toString()));
    }
  }

  Future<void> _createUser(CreateUser event, Emitter<UserState> emit) async {
    emit(UserCreateLoading());
    try {
      final userFirebaseId = ''.generateUniqueId();

      if (event.image != null) {
        final imageUrl = await locator<FirebaseStorageService>().uploadFile(
          file: event.image!,
          path: '${FirebaseStoragePathEnum.avatar.value}/$userFirebaseId/avatar_image',
        );
        event.user.photoUrl = imageUrl;
        event.user.firebaseUserID = userFirebaseId;
      }

      final response = await _userService.createUser(event.user);
      response.fold(
        onSuccess: (data) {
          emit(UserCreateCompleted());
        },
        onError: (error) {
          emit(UserCreateError(error.model?.message));
        },
      );
    } catch (e) {
      emit(UserCreateError(e.toString()));
    }
  }

  Future<void> _updateUserForAdmin(UpdateUserForAdmin event, Emitter<UserState> emit) async {
    emit(UserUpdateLoading());
    try {
      event.user.firebaseUserID ??= ''.generateUniqueId();
      if (event.image != null) {
        final imageUrl = await locator<FirebaseStorageService>().uploadFile(
          file: event.image!,
          path: '${FirebaseStoragePathEnum.avatar.value}/${event.user.firebaseUserID}/avatar_image',
        );
        event.user.photoUrl = imageUrl;
      }
      final response = await _userService.updateUserForAdmin(id: event.id, user: event.user);
      response.fold(
        onSuccess: (data) {
          emit(UserUpdateCompleted());
        },
        onError: (error) {
          emit(UserUpdateError(error.model?.message));
        },
      );
    } catch (e) {
      emit(UserUpdateError(e.toString()));
    }
  }

  Future<void> _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserUpdateLoading());
    try {
      event.user.firebaseUserID ??= ''.generateUniqueId();
      if (event.image != null) {
        final imageUrl = await locator<FirebaseStorageService>().uploadFile(
          file: event.image!,
          path: '${FirebaseStoragePathEnum.avatar.value}/${event.user.firebaseUserID}/avatar_image',
        );
        event.user.photoUrl = imageUrl;
      }
      final response = await _userService.updateUser(id: event.id, user: event.user);
      response.fold(
        onSuccess: (data) {
          emit(UserUpdateCompleted());
        },
        onError: (error) {
          emit(UserUpdateError(error.model?.message));
        },
      );
    } catch (e) {
      emit(UserUpdateError(e.toString()));
    }
  }

  Future<void> _deleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserDeleteLoading());
    try {
      final response = await _userService.deleteUserById(id: event.id);
      response.fold(
        onSuccess: (data) {
          emit(UserDeleteCompleted());
        },
        onError: (error) {
          emit(UserDeleteError(error.model?.message));
        },
      );
    } catch (e) {
      emit(UserDeleteError(e.toString()));
    }
  }

  Future<void> _changePassword(ChangePassword event, Emitter<UserState> emit) async {
    emit(ChangingPassword());
    try {
      final response = await _userService.changePassword(
        userId: event.userId,
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      response.fold(
        onSuccess: (data) {
          emit(PasswordChanged());
        },
        onError: (error) {
          emit(PasswordChangeError(error.model?.message));
        },
      );
    } catch (e) {
      emit(PasswordChangeError(e.toString()));
    }
  }

  Future<void> _fetchUsersByCity(FetchUsersByCity event, Emitter<UserState> emit) async {
    emit(UserListLoading());
    try {
      final users = await _userService.fetchUsersByCityId(event.cityId);
      emit(UserListLoadCompleted(users));
    } catch (e) {
      emit(UserListLoadError(e.toString()));
    }
  }
}
