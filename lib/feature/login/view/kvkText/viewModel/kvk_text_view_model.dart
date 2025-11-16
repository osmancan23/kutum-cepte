import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';

class KvkTextViewModel extends IBaseViewModel {
  String? _kvkHtmlText;

  String? get kvkHtmlText => _kvkHtmlText;

  set kvkHtmlText(String? value) {
    _kvkHtmlText = value;
    notifyListeners();
  }

  late IUserService _userService;

  @override
  Future<void> init() async {
    _userService = locator<UserService>();
    await _userService.fetchKvkText().then((value) {
      kvkHtmlText = value;
      notifyListeners();
    });
    return Future.value();
  }

  @override
  void reset() {}
}
