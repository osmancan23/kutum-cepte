import 'package:get_it/get_it.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/base/service/auth/auth_service.dart';
import 'package:kutum_cepte_app/core/base/service/firebase/firebase_storage_service.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/constants/app/app_constants.dart';
import 'package:kutum_cepte_app/core/constants/app/color_constants.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';
import 'package:kutum_cepte_app/feature/home/viewModel/home_view_model.dart';
import 'package:kutum_cepte_app/feature/main/viewModel/main_view_model.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';

final GetIt _locator = GetIt.instance;

GetIt get locator => _locator;

void setupLocator() {
  /// MARK: Constants
  _locator
    ..registerLazySingleton(ApplicationConstants.new)
    ..registerLazySingleton(ColorConstants.new)
    ..registerLazySingleton(VexanaManager.new)
    ..registerLazySingleton(FirebaseStorageService.new)

    /// MARK: ViewModels
    ..registerLazySingleton(MainViewModel.new)
    ..registerLazySingleton(HomeViewModel.new)

    /// MARK: API Services
    ..registerLazySingleton(AuthService.new)
    ..registerLazySingleton(UserService.new)
    ..registerLazySingleton(AddressService.new)
    ..registerLazySingleton(TaskService.new)
    ..registerLazySingleton(ShopService.new);
}
