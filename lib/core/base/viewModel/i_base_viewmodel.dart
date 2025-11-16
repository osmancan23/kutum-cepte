import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

//* View Modeller için IBaseViewModel
abstract class IBaseViewModel extends BaseViewModel {
  /// MARK: Viewmodel içerisindeki context kullanmamız gereken durumlarda
  BuildContext? context;
  // ignore: public_member_api_docs, use_setters_to_change_properties
  void setContext(BuildContext context) => this.context = context;

  /// MARK: [init]
  /// ViewModel içerisinde sayfa için yüklenirken başlatılacak olan fonksiyon
  Future<void> init();

  /// MARK: [reset]
  /// ViewModel içerisinde sayfa sonlandırıldığında sıfırlama işlemini çalıştıracak olan metod
  void reset();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeLoading() {
    _isLoading = !isLoading;
    notifyListeners();
  }
}
