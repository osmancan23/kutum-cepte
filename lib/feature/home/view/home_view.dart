import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/viewModel/home_view_model.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: locator<HomeViewModel>(),
      builder: (viewModel) {
        return SingleChildScrollView(
          child: viewModel.selectedTab?.body ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
