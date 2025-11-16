import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';

import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/textFormField/phone_input_formatter.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/hayal_sube_enum.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/user_role_enum.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/addOfficerAndUpdate/viewModel/add_officer_and_update_view_model.dart';
import 'package:kutum_cepte_app/feature/profile/widget/profile_avatar_widget.dart';
import 'package:kutum_cepte_app/utils/extension/iterable_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
// ignore: public_member_api_docs
class AddOfficerAndUpdateView extends StatefulWidget {
  const AddOfficerAndUpdateView({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<AddOfficerAndUpdateView> createState() => _AddOfficerAndUpdateViewState();
}

class _AddOfficerAndUpdateViewState extends State<AddOfficerAndUpdateView> {
  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: AddOfficerAndUpdateViewModel(userModel: widget.userModel),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: viewModel.userModel == null ? 'Kullanıcı Ekle' : 'Kullanıcı Güncelle',
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileAvatarWidget(
                  onSelect: (image) {
                    viewModel.image = image;
                  },
                  isAuthUser: false,
                  photoUrl: widget.userModel?.photoUrl,
                ),
                20.h.ph,
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Ad',
                        initialValue: widget.userModel?.name,
                        onSaved: (value) => viewModel.name = value,
                        title: 'Ad',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ad alanı boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        hintText: 'Soyad',
                        initialValue: widget.userModel?.surname,
                        onSaved: (value) => viewModel.surname = value,
                        title: 'Soyad',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Soyad alanı boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonWidget(
                        options:
                            UserRoleEnum.values.where((e) => e != UserRoleEnum.superAdmin).map((e) => e.title).toList(),
                        hintText: 'Kullanıcı Türü',
                        value: viewModel.role?.title,
                        onChange: (value) => viewModel.role =
                            UserRoleEnum.values.where((element) => element.title == value).getIterableItem(0),
                        title: 'Kullanıcı Türü',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kullanıcı seçilmelidir';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        hintText: 'Telefon',
                        initialValue: widget.userModel?.phone,
                        onSaved: (value) => viewModel.phone = value,
                        title: 'Telefon',
                        textInputType: TextInputType.phone,
                        inputFormatters: [PhoneInputFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefon numarası boş olamaz';
                          }
                          return null;
                        },
                      ),
                      AddressDropDownButtonWidget(
                        onChange: (city) {
                          viewModel.city = AddressModel(id: city!.id, title: city.title);
                          viewModel.districtBloc.add(FetchDistricts(cityId: city.id!));
                          viewModel.district = null;
                        },
                        addressBloc: viewModel.cityBloc,
                        type: AddressDropDownType.city,
                        initialAddress: viewModel.city?.title,
                        title: 'Şehir',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Şehir seçilmelidir';
                          }
                          return null;
                        },
                      ),
                      10.h.ph,
                      AddressDropDownButtonWidget(
                        onChange: (district) {
                          viewModel.district = AddressModel(
                            id: district!.id,
                            title: district.title,
                          );
                        },
                        addressBloc: viewModel.districtBloc,
                        type: AddressDropDownType.district,
                        initialAddress: viewModel.district?.title,
                        title: 'İlçe',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'İlçe seçilmelidir';
                          }
                          return null;
                        },
                      ),
                      if (widget.userModel != null)
                        const SizedBox.shrink()
                      else
                        TextFormFieldWidget(
                          isPassword: true,
                          hintText: 'Şifre',
                          onSaved: (value) => viewModel.password = value,
                          title: 'Şifre',
                          suffixIcon: IconEnums.hide,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Şifre alanı boş bırakılamaz';
                            }
                            return null;
                          },
                        ),
                      10.h.ph,
                      DropdownButtonWidget(
                        options: HayalSubeEnum.values.map((e) => e.value).toList(),
                        hintText: 'Hayal Şubesi',
                        onChange: (p0) => viewModel.hayalSube = p0,
                        value: viewModel.hayalSube,
                        title: 'Hayal Şubesi',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Şube seçilmelidir';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                40.h.ph,
                ButtonWidget(
                  onTap: () {
                    if (viewModel.formKey.currentState?.validate() ?? false) {
                      viewModel.formKey.currentState?.save();
                      viewModel.createOrUpdateUser();
                    }
                  },
                  text: widget.userModel == null ? 'Kullanıcı Ekle' : 'Kullanıcı Güncelle',
                ),
                40.h.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}
