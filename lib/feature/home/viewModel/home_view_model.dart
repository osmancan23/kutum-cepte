import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/constants/enums/tabbar_enums.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';

final class HomeViewModel extends IBaseViewModel {
  TabbarItemEnum? _selectedTab;

  TabbarItemEnum? get selectedTab => _selectedTab;

  set selectedTab(TabbarItemEnum? value) {
    _selectedTab = value;
    notifyListeners();
  }

  @override
  Future<void> init() {
    _selectedTab = context!.isAdmin ? TabbarItemEnum.taskAssignment : TabbarItemEnum.collectionTaskList;
    return Future.value();
  }

  @override
  void reset() {}
}
