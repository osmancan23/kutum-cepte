part of '../viewModel/shop_create_view_model.dart';

mixin _ShopCreateViewMixin on IBaseViewModel {
  String? _shopName;

  String? get shopName => _shopName;

  set shopName(String? value) {
    _shopName = value;
    notifyListeners();
  }

  int? _cityId;

  int? get cityId => _cityId;

  set cityId(int? value) {
    _cityId = value;
    notifyListeners();
  }

  String? _cityName;

  String? get cityName => _cityName;

  set cityName(String? value) {
    _cityName = value;
    notifyListeners();
  }

  int? _districtId;

  int? get districtId => _districtId;

  set districtId(int? value) {
    _districtId = value;
    notifyListeners();
  }

  String? _districtName;

  String? get districtName => _districtName;

  set districtName(String? value) {
    _districtName = value;
    notifyListeners();
  }

  final TextEditingController _streetController = TextEditingController();

  TextEditingController get streetController => _streetController;

  String? _street;

  String? get street => _street;

  set street(String? value) {
    _street = value;
    notifyListeners();
  }

  List<String> _streetList = [];

  List<String> get streetList => _streetList;

  set streetList(List<String> value) {
    _streetList = value;
    notifyListeners();
  }

  String? _shopAddress;

  String? get shopAddress => _shopAddress;

  set shopAddress(String? value) {
    _shopAddress = value;
    notifyListeners();
  }

  Map<int, File?> _shopImageList = {0: null, 1: null, 2: null};

  Map<int, File?> get shopImageList => _shopImageList;

  set shopImageList(Map<int, File?> value) {
    _shopImageList = value;
    notifyListeners();
  }

  double? _latitude;

  double? get latitude => _latitude;

  set latitude(double? value) {
    _latitude = value;
    notifyListeners();
  }

  double? _longitude;

  double? get longitude => _longitude;

  set longitude(double? value) {
    _longitude = value;
    notifyListeners();
  }

  int? _boxCount = 1;

  int? get boxCount => _boxCount;

  set boxCount(int? value) {
    _boxCount = value;
    notifyListeners();
  }

  List<MarkerModel> _locations = [];

  List<MarkerModel> get locations => _locations;

  set locations(List<MarkerModel> value) {
    log('Gelen Locations: $value');
    _locations = value;
    notifyListeners();
  }
}
