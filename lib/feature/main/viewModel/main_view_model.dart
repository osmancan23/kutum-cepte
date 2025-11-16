import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/feature/home/view/home_view.dart';
import 'package:kutum_cepte_app/feature/identityCard/identity_card_view.dart';
import 'package:kutum_cepte_app/feature/profile/profile_view.dart';
import 'package:kutum_cepte_app/feature/reports/reports_view.dart';

final class MainViewModel extends IBaseViewModel {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  ValueNotifier<int> get selectedIndex => _selectedIndex;

  void clearIndex() {
    _selectedIndex.value = 0;
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const ReportsView(),
    const IdentityCardView(),
    const ProfileView(),
  ];

  Widget get widgetOptions => _widgetOptions.elementAt(_selectedIndex.value);
  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  void reset() {}
}
