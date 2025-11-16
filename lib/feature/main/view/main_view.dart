import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/appbar/appbar.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/tabbar_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/viewModel/home_view_model.dart';

import 'package:kutum_cepte_app/feature/main/viewModel/main_view_model.dart';
import 'package:kutum_cepte_app/feature/profile/widget/profile_avatar_widget.dart';
import 'package:kutum_cepte_app/product/widget/bottombar/bottom_navbar_widget.dart';
import 'package:kutum_cepte_app/product/widget/tabbar/tabbar_widget.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part '../../home/widget/home_appbar_widget.dart';
part '../widget/app_bar_widget.dart';
part '../../identityCard/widget/identity_card_appbar_widget.dart';

@RoutePage()
final class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: locator<MainViewModel>(),
      builder: (viewModel) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const _AppbarWidget(),
          body: Padding(
            padding: context.padding.horizontalNormal,
            child: ValueListenableBuilder(
              valueListenable: viewModel.selectedIndex,
              builder: (context, value, child) {
                return viewModel.widgetOptions;
              },
            ),
          ),
          bottomNavigationBar: BottomNavbarWidget(
            onItemTap: (p0) => viewModel.selectedIndex.value = p0,
          ),
        );
      },
    );
  }
}
