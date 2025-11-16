import 'dart:async';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';

final class ChangePasswordViewModel extends IBaseViewModel {
  final formKey = GlobalKey<FormState>();

  String? _currentPassword;

  String? get currentPassword => _currentPassword;

  set currentPassword(String? value) {
    _currentPassword = value;
    notifyListeners();
  }

  String? _newPassword;

  String? get newPassword => _newPassword;

  set newPassword(String? value) {
    _newPassword = value;
    notifyListeners();
  }

  String? _newPasswordAgain;

  String? get newPasswordAgain => _newPasswordAgain;

  set newPasswordAgain(String? value) {
    _newPasswordAgain = value;
    notifyListeners();
  }

  late UserBloc _userBloc;

  late StreamSubscription<UserState> _userBlocSubscription;

  @override
  Future<void> init() async {
    try {
      _userBloc = UserBloc(locator<UserService>());

      _userBlocSubscription = _userBloc.stream.listen((event) {
        if (event is PasswordChanged) {
          changeLoading();
          snackbarWidget(context!, message: 'Şifreniz başarıyla değiştirildi');
          context!.router.back();
        } else if (event is PasswordChangeError) {
          changeLoading();
          snackbarWidget(context!,
              message: event.error ?? 'Bir hata oluştu',
              type: SnackbarType.error);
        }
      });
    } catch (e, stackTrace) {


      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }
    return Future.value();
  }

  @override
  Future<void> reset() async {
    await _userBlocSubscription.cancel();
    await _userBloc.close();
  }

  void changePassword() {
    try {
      formKey.currentState!.save();

      if (currentPassword == null ||
          newPassword == null ||
          newPasswordAgain == null) {
        snackbarWidget(context!,
            message: 'Lütfen tüm alanları doldurunuz',
            type: SnackbarType.error);
        return; // Hatalı durumda işlemi sonlandır
      }

      if (newPassword != newPasswordAgain) {
        snackbarWidget(context!,
            message: 'Şifreler uyuşmuyor', type: SnackbarType.error);
        return; // Hatalı durumda işlemi sonlandır
      }

      changeLoading();

      _userBloc.add(ChangePassword(context!.read<AuthBloc>().state.user!.id!,
          currentPassword!, newPassword!));
    } catch (e, stackTrace) {

      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }
  }
}
