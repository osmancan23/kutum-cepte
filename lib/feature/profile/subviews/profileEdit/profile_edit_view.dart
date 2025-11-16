import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/phone_input_formatter.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/profileEdit/viewModel/profile_edit_view_model.dart';
import 'package:kutum_cepte_app/feature/profile/widget/profile_avatar_widget.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: ProfileEditViewModel(),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'Profil Düzenle',
          body: Center(
            child: Column(
              children: [
                40.h.ph,
                ProfileAvatarWidget(
                  onSelect: (image) {
                    viewModel.image = image;
                  },
                ),
                10.h.ph,
                CustomText(
                  '${viewModel.name} ${viewModel.surname}',
                  textStyle: context.general.textTheme.headlineLarge,
                ),
                10.h.ph,
                CustomText(
                  viewModel.phone,
                  textStyle: context.general.textTheme.bodySmall?.copyWith(),
                ),
                20.h.ph,
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Ad Soyad',
                        initialValue: '${viewModel.name} ${viewModel.surname}',
                        onSaved: (value) {
                          viewModel.name = value!.split(' ')[0];
                          viewModel.surname = value.split(' ')[1];
                        },
                      ),
                      TextFormFieldWidget(
                        hintText: 'Telefon',
                        initialValue: viewModel.phone,
                        textInputType: TextInputType.phone,
                        inputFormatters: [PhoneInputFormatter()],
                        onSaved: (value) {
                          viewModel.phone = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefon numarası boş olamaz';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                30.h.ph,
                ButtonWidget(
                  onTap: () => viewModel.updateProfile(),
                  text: 'Güncelle',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
