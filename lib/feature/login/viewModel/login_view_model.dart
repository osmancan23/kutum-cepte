import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';

final class LoginViewModel extends IBaseViewModel {
  String? phone;
  String? password;
  late AuthBloc _authBloc;
  final GlobalKey<FormState> formKey = GlobalKey();
  late StreamSubscription<AuthState> _authBlocSubscription;

  @override
  Future<void> init() {
    _authBloc = context!.read<AuthBloc>();
    _authBlocSubscription = _authBloc.stream.listen((event) async {
      if (context?.mounted ?? false) {
        log('Status: ${event.status}');
        if (event.status == AuthStatus.authenticated) {
          await Future.delayed(const Duration(seconds: 2), () {
            changeLoading();

            if (context?.mounted ?? false) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                context!.router.replace(const MainRoute());
              });
            }
          });
        } else if (event.status == AuthStatus.error) {
          isLoading = false;
          snackbarWidget(
            context!,
            message: event.errorMessage ?? 'Hatalı telefon no yada şifre',
            type: SnackbarType.error,
          );
        }
      }
    });
    return Future.value();
  }

  @override
  Future<void> reset() async {
    await _authBlocSubscription.cancel();
  }

  void login() {
    formKey.currentState!.save();

    try {
      if (!formKey.currentState!.validate()) return;

      changeLoading();
      print('Phone: $phone, Password: $password');
      _authBloc.add(
          LoginRequested(phone: phone!.trim(), password: password!.trim()));
    } catch (e) {

      log('Error: $e');
      isLoading = false;
    }
  }
}
