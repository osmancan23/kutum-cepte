import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/feature/home/view/home_view.dart';
import 'package:kutum_cepte_app/feature/identityCard/identity_card_view.dart';
import 'package:kutum_cepte_app/feature/login/view/kvkText/kvk_text_view.dart';
import 'package:kutum_cepte_app/feature/login/view/login_view.dart';

import 'package:kutum_cepte_app/feature/main/view/main_view.dart';
import 'package:kutum_cepte_app/feature/profile/profile_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/addOfficerAndUpdate/view/add_officer_and_update_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/changePassword/view/change_password_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/officers/officers_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/profileEdit/profile_edit_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/resetShops/view/reset_shops_view.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/shopList/shop_list_view.dart';
import 'package:kutum_cepte_app/feature/reports/reports_view.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/view/shopCreate/shop_create_view.dart';
import 'package:kutum_cepte_app/feature/shop/view/shopDetail/shop_detail_view.dart';
import 'package:kutum_cepte_app/feature/shop/view/shopDetail/widget/full_screen_image.dart';
import 'package:kutum_cepte_app/feature/shop/view/shopEdit/shop_edit_view.dart';
import 'package:kutum_cepte_app/feature/splash/view/splash_view.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: KvkTextRoute.page),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: ReportsRoute.page),
            AutoRoute(page: IdentityCardRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: ShopDetailRoute.page),
        AutoRoute(page: ShopEditRoute.page),
        AutoRoute(page: ShopCreateRoute.page),
        AutoRoute(page: OfficersRoute.page),
        AutoRoute(page: ProfileEditRoute.page),
        AutoRoute(page: AddOfficerAndUpdateRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: FullScreenImageRoute.page),
        AutoRoute(page: ResetBoxesRoute.page),
        AutoRoute(page: ShopListRoute.page),
      ];
}
