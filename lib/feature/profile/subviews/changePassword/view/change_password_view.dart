import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/changePassword/viewModel/change_password_view_model.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: ChangePasswordViewModel(),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'Şifre Değiştir',
          body: Column(
            children: [
              20.h.ph,
              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    _buildTextFormFieldWidget(
                      context,
                      onSaved: (value) {
                        viewModel.currentPassword = value;
                      },
                      hintText: 'Mevcut Şifre:',
                    ),
                    _buildTextFormFieldWidget(
                      context,
                      onSaved: (value) {
                        viewModel.newPassword = value;
                      },
                      hintText: 'Yeni Şifre:',
                    ),
                    _buildTextFormFieldWidget(
                      context,
                      onSaved: (value) {
                        viewModel.newPasswordAgain = value;
                      },
                      hintText: 'Yeni Şifre Tekrar:',
                    ),
                  ],
                ),
              ),
              40.h.ph,
              ButtonWidget(
                onTap: () => viewModel.changePassword(),
                text: 'Güncelle',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFormFieldWidget(
    BuildContext context, {
    required void Function(String? val) onSaved,
    required String hintText,
  }) {
    return TextFormFieldWidget(
      onSaved: (value) => onSaved(value),
      hintText: hintText,
      prefixIcon: IconEnums.lock,
      isPassword: true,
      borderWidth: 0,
      suffixIcon: IconEnums.hide,
    );
  }
}
