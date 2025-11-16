import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/update_and_create_user_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/constants/enums/user_role_enum.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/utils/extension/iterable_extensions.dart';
part '../mixin/add_officer_and_update_view_mixin.dart';

final class AddOfficerAndUpdateViewModel extends IBaseViewModel with _AddOfficerAndUpdateViewMixin {
  AddOfficerAndUpdateViewModel({required this.userModel});
  UserModel? userModel;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserBloc userBloc;
  late StreamSubscription<UserState> _userBlocSubscription;
  late AddressBloc cityBloc;
  late AddressBloc districtBloc;

  @override
  Future<void> init() async {
    cityBloc = AddressBloc(locator<AddressService>());
    cityBloc.add(FetchCities());
    districtBloc = AddressBloc(locator<AddressService>());
    userBloc = context!.read<UserBloc>();

    await _fetchUserDetail();

    _userBlocSubscription = userBloc.stream.listen((event) {
      if (event is UserCreateCompleted ||
          event is UserUpdateCompleted ||
          event is UserCreateError ||
          event is UserUpdateError) {
        changeLoading();
        snackbarWidget(
          context!,
          message: "Kullanıcı başarıyla ${userModel == null ? 'eklendi' : 'güncellendi'}",
        );
        context!.router.back();
      }
    });
    return Future.value();
  }

  @override
  Future<void> reset() async {
    await _userBlocSubscription.cancel();
  }

  ///MARK: - Fetch User Detail for Update User

  Future<void> _fetchUserDetail() async {
    try {
      if (userModel != null) {
        await locator<UserService>().fetchUserById(userModel!.id!).then((value) {
          name = value?.name;
          surname = value?.surname;
          phone = value?.phone;
          role = UserRoleEnum.values.where((element) => element.value == value?.role).getIterableItem(0);
          hayalSube = value?.hayalSube;

          city = value?.sehirDto;
          district = value?.ilceDto;
          firebaseUserID = value?.firebaseUserID;
        });
      }
    } catch (e, stackTrace) {

      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }
  }

  void createOrUpdateUser() {
    try {
      formKey.currentState?.save();

      if (userModel == null) {
        if (name != null && surname != null && phone != null && role != null && hayalSube != null) {
          changeLoading();

          userBloc.add(
            CreateUser(
              UpdateAndCreateUserModel(
                name: name,
                surname: surname,
                phone: phone,
                role: role?.value,
                hayalSube: hayalSube,
                photoUrl: userModel?.photoUrl,
                firebaseUserID: firebaseUserID,
                sehirId: city?.id,
                ilceId: district?.id,
                password: password,
              ),
              image,
            ),
          );
        } else {
          snackbarWidget(context!, message: 'Lütfen tüm alanları doldurunuz');
        }
      } else {
        changeLoading();

        userBloc.add(
          UpdateUserForAdmin(
            userModel!.id!,
            UpdateAndCreateUserModel(
              name: name,
              surname: surname,
              phone: phone,
              role: role?.value,
              hayalSube: hayalSube,
              photoUrl: userModel?.photoUrl,
              firebaseUserID: firebaseUserID,
              sehirId: city?.id,
              ilceId: district?.id,
            ),
            image,
          ),
        );
      }
    } catch (e, stackTrace) {
      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }

  }
}
