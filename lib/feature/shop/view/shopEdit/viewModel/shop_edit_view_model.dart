import 'dart:io';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_image_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_update_model.dart';
part '../mixin/shop_edit_view_mixin.dart';

class ShopEditViewModel extends IBaseViewModel with _ShopEditViewMixin {
  ShopEditViewModel(this.shopModel);

  final ShopModel shopModel;

  late AddressBloc cityBloc;
  late AddressBloc districtBloc;
  late ShopBloc _shopBloc;
  @override
  Future<void> init() {
    _shopBloc = context!.read<ShopBloc>();
    cityBloc = AddressBloc(locator<AddressService>());
    districtBloc = AddressBloc(locator<AddressService>());

    cityBloc.add(FetchCities());

    shopNameController.text = shopModel.title ?? '';
    shopOwnerController.text = shopModel.personName ?? '';
    city = shopModel.sehirDto;
    district = shopModel.ilceDto;
    boxCount = shopModel.boxCount;
    shopAddressController.text = shopModel.description ?? '';
    shopModel.shopPhotosUrl?.map((e) {
      final index = shopModel.shopPhotosUrl!.indexOf(e);
      newShopImageList[index] = null;
    });
    latitude = double.tryParse(shopModel.latitudeCordinate ?? '') ?? 0;
    longitude = double.tryParse(shopModel.longitudeCordinate ?? '') ?? 0;

    _shopBloc.stream.listen((state) {
      if (state is ShopUpdated) {
        isLoading = false;
        snackbarWidget(context!, message: 'Dükkan başarıyla güncellendi');
        context!.router.replaceAll([const MainRoute()]);
      } else if (state is ShopUpdateError) {
        isLoading = false;
        snackbarWidget(
          context!,
          message: 'Dükkan güncellenirken bir hata oluştu',
          type: SnackbarType.error,
        );
      }
    });

    return Future.value();
  }

  @override
  void reset() {}

  void addShopImage(int id, File? image) {
    final isThere = newShopImageList.entries.any((element) => element.key == id);

    if (isThere) {
      newShopImageList[id] = image;
    }
    notifyListeners();
  }


void updateShop() {
  try {
    changeLoading();
    _shopBloc.add(
      UpdateShop(
        ShopUpdateModel(
          title: shopNameController.text,
          personName: shopOwnerController.text,
          sehirId: city!.id,
          ilceId: district!.id,
          boxCount: boxCount,
          description: shopAddressController.text,
          latitudeCordinate: latitude.toString(),
          longitudeCordinate: longitude.toString(),
          shopNo: shopModel.shopNo,
          firebaseShopID: shopModel.firebaseShopID,
          // shopPhotosUrl: newShopImageList.values.toList(),
        ),
        shopModel.id!,
        newShopImageList.entries
            .map(
              (e) => ShopImageModel(
                image: e.value,
                id: e.key,
              ),
            )
            .toList(),
      ),
    );
  } catch (e, stackTrace) {


    rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
  } finally {
    changeLoading();
  }
}
}
