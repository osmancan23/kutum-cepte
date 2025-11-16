import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_create_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_image_model.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
part '../mixin/shop_create_view_mixin.dart';

class ShopCreateViewModel extends IBaseViewModel with _ShopCreateViewMixin {
  late AddressBloc cityBloc;
  late AddressBloc districtBloc;
  late ShopBloc shopBloc;
  late StreamSubscription<ShopState> _shopSubscription;
  late GlobalKey<FormState> formKey;

  @override
  Future<void> init() async {
    formKey = GlobalKey<FormState>();
    cityBloc = AddressBloc(locator<AddressService>());
    districtBloc = AddressBloc(locator<AddressService>());
    shopBloc = ShopBloc(ShopService());
    cityBloc.add(FetchCities());
    _listenBloc();


    return Future.value();
  }

  void _listenBloc() {
    _shopSubscription = shopBloc.stream.listen((state) {
      if (state is ShopCreated) {
        isLoading = false;
        clearAllValues();
        snackbarWidget(context!, message: 'Dükkan başarıyla oluşturuldu');
        context!.router.push(const HomeRoute());
      } else if (state is ShopCreateError) {
        isLoading = false;
        snackbarWidget(
          context!,
          message: 'Dükkan oluşturulurken bir hata oluştu',
          type: SnackbarType.error,
        );
      } else if (state is ShopListLoaded) {
        final list = <MarkerModel>[];
        for (final shop in state.shopList) {
          list.add(
            MarkerModel(
              id: shop.id.toString(),
              latitude: shop.latitudeCordinate!.toDouble,
              longitude: shop.longitudeCordinate!.toDouble,
              title: '${shop.title} Dükkan No: ${shop.shopNo}',
              shopNo: shop.shopNo,
              markerType: MarkerType.handleMarkerType(shop.shopStatus),
            ),
          );
        }
        locations = list;
        notifyListeners();
      }
    });
  }

  @override
  Future<void> reset() async {
    await _shopSubscription.cancel();
  }

  void addShopImage(int id, File? image) {
    final isThere = shopImageList.entries.any((element) => element.key == id);

    if (isThere) {
      shopImageList[id] = image;
    }
    notifyListeners();
  }

  void clearAllValues() {
    shopName = null;
    cityId = null;
    districtId = null;
    shopAddress = null;
    latitude = null;
    longitude = null;
    shopImageList.clear();

    notifyListeners();
  }

  bool validateValues() {
    if (shopName != null &&
        cityId != null &&
        districtId != null &&
        shopAddress != null &&
        latitude != null &&
        longitude != null &&
        shopImageList.isNotEmpty) {
      return true;
    }
    snackbarWidget(
      context!,
      message: 'Lütfen tüm alanları doldurun',
      type: SnackbarType.error,
    );
    return false;
  }

  Future<void> createShop() async {
    formKey.currentState?.save();
    log('Shop Name: $shopName');
    log('City Id: $cityId');
    log('District Id: $districtId');
    log('Shop Address: $shopAddress');
    log('Latitude: $latitude');
    log('Longitude: $longitude');
    log('Shop Image List: ${shopImageList.length}');

    try {
      if (validateValues()) {
        changeLoading();

        shopBloc.add(
          CreateShop(
            ShopCreateModel(
              title: shopName,
              sehirId: cityId,
              ilceId: districtId,
              description: shopAddress,
              latitudeCordinate: latitude,
              longitudeCordinate: longitude,
              boxCount: boxCount ?? 1,
              createDate: DateTime.now().formattedDate,
              createUserId: context!.read<AuthBloc>().state.user!.id,
            ),
            shopImageList.entries.map((e) => ShopImageModel(image: e.value, id: e.key)).toList(),
          ),
        );

/*         ReportBloc(ReportService()).add(FetchWorkerReportList(
        context!.read<AuthBloc>().state.user!.id!, DateTime.now().formattedDate)); */
      }
    } catch (e, stackTrace) {
      isLoading = false;
    }
  }
}
