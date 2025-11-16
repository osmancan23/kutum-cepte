import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/constants/enums/user_role_enum.dart';

extension ClosePopupExtension on BuildContext {
  void closePopup({Object? backData}) {
    Navigator.of(this, rootNavigator: true).pop(backData);
  }
}

extension UserTypeExtension on BuildContext {
  ///[MARK: isAdmin] is a custom extension method that returns a boolean value.
  bool get isAdmin =>
      read<AuthBloc>().state.user?.role == UserRoleEnum.admin.value ||
      read<AuthBloc>().state.user?.role == UserRoleEnum.superAdmin.value;

  bool get isSuperAdmin => read<AuthBloc>().state.user?.role == UserRoleEnum.superAdmin.value;
}

extension DecorationExtension on BuildContext {
  ///[MARK: getBoxShadow] is a custom extension method that returns a list of BoxShadow.
  List<BoxShadow> get getBoxShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.07),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ];
}
