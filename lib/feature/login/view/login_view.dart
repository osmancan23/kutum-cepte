import 'package:auto_route/auto_route.dart';
import 'package:country_code_text_field/country_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/feature/login/viewModel/login_view_model.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: LoginViewModel(),
      builder: (LoginViewModel viewModel) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  50.h.ph,
                  SizedBox(
                    width: 380.w,
                    height: 200.h,
                    child: SvgPicture.asset(ImageEnums.login.svgPath),
                  ),
                  20.h.ph,
                  CustomText(
                    'Hadi Başlayalım',
                    textStyle: context.general.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  30.h.ph,
                  Padding(
                    padding: context.padding.horizontalMedium,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              _PhoneNumberTextFieldWidget(onSaved: (phone) => viewModel.phone = phone),
                              TextFormFieldWidget(
                                fontSize: 16,
                                isPassword: true,
                                hintText: 'Parola',
                                prefixIcon: IconEnums.lock,
                                suffixIcon: IconEnums.hide,
                                onSaved: (value) => viewModel.password = value,
                                validator: (p0) => p0.ext.isNotNullOrNoEmpty ? null : 'Parola boş olamaz',
                              ),
                            ],
                          ),
                        ),
                        50.h.ph,
                        ButtonWidget(
                          onTap: () => viewModel.login(),
                          text: 'Giriş Yap',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PhoneNumberTextFieldWidget extends StatelessWidget {
  const _PhoneNumberTextFieldWidget({required this.onSaved});
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.general.colorScheme.primaryContainer,
        borderRadius: context.border.lowBorderRadius,
      ),
      child: CountryCodeTextField(
        countries: const ['TR', 'DE'],
        cursorColor: context.general.colorScheme.primary,
        invalidNumberMessage: 'Geçerli bir telefon numarası giriniz',
        decoration: InputDecoration(
          hintText: '(___) ___ __ __ (Cep No)',
          hintStyle: context.general.textTheme.bodySmall?.copyWith(
            color: context.general.colorScheme.secondary,
          ),
          border: _buildOutlineInputBorder(context),
          focusedBorder: _buildOutlineInputBorder(context),
          enabledBorder: _buildOutlineInputBorder(context),
          disabledBorder: _buildOutlineInputBorder(context),
          focusedErrorBorder: _buildOutlineInputBorder(context),
        ),
        initialCountryCode: 'TR',
        onSaved: (phone) => onSaved.call(
          phone?.completeNumber.startsWith('0') ?? false ? phone?.completeNumber : phone?.completeNumber.substring(2),
        ),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(BuildContext context, {Color? color}) {
    return OutlineInputBorder(
      borderRadius: context.border.lowBorderRadius,
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: 0,
      ),
    );
  }
}
