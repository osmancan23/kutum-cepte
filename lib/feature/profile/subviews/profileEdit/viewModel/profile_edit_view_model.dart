import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/update_and_create_user_model.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';

class ProfileEditViewModel extends IBaseViewModel {
  String? name;
  String? surname;
  String? phone;
  late UserBloc _userBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StreamSubscription<UserState> _userBlocSubscription;
  File? image;

  @override

Future<void> init() async {
  try {
    _userBloc = UserBloc(locator<UserService>());
    name = context!.read<AuthBloc>().state.user?.name;
    surname = context!.read<AuthBloc>().state.user?.surname;
    phone = context!.read<AuthBloc>().state.user?.phone;

    _userBlocSubscription = _userBloc.stream.listen((event) async {
      if (event is UserUpdateCompleted) {
        changeLoading();
        context?.read<AuthBloc>().add(UpdateGlobalBlocUser(context!));

        snackbarWidget(context!, message: 'Profiliniz başarıyla güncellendi');
      } else if (event is UserUpdateError) {
        isLoading = false;
        snackbarWidget(context!, message: 'Profiliniz güncellenirken bir hata oluştu', type: SnackbarType.error);
      }
    });
  } catch (e, stackTrace) {

    rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
  }
  return Future.value();
}
  @override
  Future<void> reset() async {
    await _userBloc.close();

    await _userBlocSubscription.cancel();
  }

void updateProfile() {
  try {
    formKey.currentState?.save();

    if (formKey.currentState!.validate()) {
      changeLoading();
      _userBloc.add(
        UpdateUser(
          context!.read<AuthBloc>().state.user!.id!,
          UpdateAndCreateUserModel(
            name: name,
            surname: surname,
            phone: phone,
            photoUrl: context!.read<AuthBloc>().state.user!.photoUrl,
            sehirId: context!.read<AuthBloc>().state.user!.sehirDto!.id,
            ilceId: context!.read<AuthBloc>().state.user!.ilceDto!.id,
            hayalSube: context!.read<AuthBloc>().state.user!.hayalSube,
            firebaseUserID: context!.read<AuthBloc>().state.user!.firebaseUserID,
          ),
          image,
          context!,
        ),
      );
    }
  } catch (e, stackTrace) {

    rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
  }
}
}
