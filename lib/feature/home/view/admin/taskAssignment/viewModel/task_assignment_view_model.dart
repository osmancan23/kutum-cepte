import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/model/create_collector_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/create_distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
part '../mixin/task_assignment_view_mixin.dart';

class TaskAssignmentViewModel extends IBaseViewModel with _TaskAssignmentViewMixin {
  late AddressBloc cityBloc;
  late AddressBloc districtBloc;
  late TaskBloc taskBloc;
  late UserBloc userBloc;
  late ShopBloc _shopBloc;
  late StreamSubscription<TaskState> _taskBlocSubscription;
  late StreamSubscription<ShopState> _shopBlocSubscription;
  @override
  Future<void> init() {
    cityBloc = AddressBloc(locator<AddressService>());
    districtBloc = AddressBloc(locator<AddressService>());
    taskBloc = TaskBloc(TaskService());
    userBloc = UserBloc(UserService());
    _shopBloc = ShopBloc(locator<ShopService>());

    cityBloc.add(FetchCities());

    _taskBlocSubscription = taskBloc.stream.listen((event) {
      if (event is CreatedCollectorTask || event is CreatedDistirubutorTask) {
        isLoading = false;
        snackbarWidget(
          context!,
          message: 'Görev başarıyla oluşturuldu',
        );

        _shopBloc.add(
          FetchAllShops(sehirId: cityId!, ilceId: districtId!),
        );
      } else if (event is TaskCreateError) {
        isLoading = false;

        snackbarWidget(
          context!,
          message: event.error,
          type: SnackbarType.error,
        );
      }
    });

    _shopBlocSubscription = _shopBloc.stream.listen((event) {
      if (event is ShopListLoaded) {
        final list = <MarkerModel>[];
        for (final shop in event.shopList) {
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
    return Future.value();
  }

  @override
  void reset() {
    cityBloc.close();
    districtBloc.close();
    taskBloc.close();
    userBloc.close();
    _shopBloc.close();
    _taskBlocSubscription.cancel();
    _shopBlocSubscription.cancel();
  }

  void selectDistrict(AddressModel? value) {
    districtId = value?.id;

    if (cityId != null && districtId != null) {
      _shopBloc.add(
        FetchAllShops(sehirId: cityId!, ilceId: districtId!),
      );
    }
  }

  void selectCity(AddressModel? value) {
    cityId = value?.id;
    districtBloc.add(
      FetchDistricts(
        cityId: cityId!,
      ),
    );
    userBloc.add(FetchUsersByCity(cityId!));
  }

  void createTask() {
    try {
      log('selectedUserId: $selectedUserId');
      log('cityId: $cityId');
      log('districtId: $districtId');
      log('date: $date');
      log('startHour: $startHour');
      log('endHour: $endHour');
      log('streets: $streetList');
      log('boxNoStart: $boxNoStart');
      log('boxNoEnd: $boxNoEnd');

      if (taskType == TaskType.distributor) {
        if (selectedUserId != null && cityId != null && districtId != null && date != null && streetList.isNotEmpty) {
          taskBloc.add(
            CreateDistirubutorTask(
              createDistirubutorTaskModel: CreateDistributorTaskModel(
                userId: selectedUserId,
                adminUserId: 1,
                sehirId: cityId,
                ilceId: districtId,
                startTime: '$startHour:00',
                finishTime: '$endHour:00',
                taskDate: date?.formattedDate,
                sokaks: {for (final street in streetList) street: false},
              ),
            ),
          );
        } else {
          snackbarWidget(
            context!,
            message: 'Lütfen tüm alanları doldurunuz',
            type: SnackbarType.error,
          );
        }
      } else {
        if (selectedUserId != null &&
            cityId != null &&
            districtId != null &&
            date != null &&
            boxNoStart != null &&
            boxNoEnd != null) {
          taskBloc.add(
            CreateCollectorTask(
              createCollectorTaskModel: CreateCollectorTaskModel(
                userId: selectedUserId,
                adminUserId: 1,
                sehirId: cityId,
                ilceId: districtId,
                taskDate: date?.formattedDate,
                minShopNo: boxNoStart,
                maxShopNo: boxNoEnd,
                startTime: '$startHour:00',
                finishTime: '$endHour:00',
              ),
            ),
          );
        } else {
          snackbarWidget(
            context!,
            message: 'Lütfen tüm alanları doldurunuz',
            type: SnackbarType.error,
          );
        }
      }
    } catch (e, stackTrace) {
      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }

  }
}
