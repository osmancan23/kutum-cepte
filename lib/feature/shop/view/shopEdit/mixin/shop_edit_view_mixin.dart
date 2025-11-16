part of '../viewModel/shop_edit_view_model.dart';

mixin _ShopEditViewMixin on IBaseViewModel {
  final TextEditingController _shopNameController = TextEditingController();

  TextEditingController get shopNameController => _shopNameController;

  final TextEditingController _shopOwnerController = TextEditingController();

  TextEditingController get shopOwnerController => _shopOwnerController;

  AddressModel? _city;

  AddressModel? get city => _city;

  set city(AddressModel? value) {
    _city = value;
    notifyListeners();
  }

  AddressModel? _district;

  AddressModel? get district => _district;

  set district(AddressModel? value) {
    _district = value;
    notifyListeners();
  }



  int? _boxCount;

  int? get boxCount => _boxCount;

  set boxCount(int? value) {
    _boxCount = value;
    notifyListeners();
  }

  final TextEditingController _shopAddressController = TextEditingController();

  TextEditingController get shopAddressController => _shopAddressController;

  // Will use when user wants to add new shop images
  Map<int, File?> _newShopImageList = {0: null, 1: null, 2: null};

  Map<int, File?> get newShopImageList => _newShopImageList;

  set newShopImageList(Map<int, File?> value) {
    _newShopImageList = value;
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
}
