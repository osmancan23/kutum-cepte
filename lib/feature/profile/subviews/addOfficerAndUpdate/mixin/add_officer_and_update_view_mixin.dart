part of '../viewModel/add_officer_and_update_view_model.dart';

mixin _AddOfficerAndUpdateViewMixin on IBaseViewModel {
  String? _name;

  String? get name => _name;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  String? _surname;

  String? get surname => _surname;

  set surname(String? value) {
    _surname = value;
    notifyListeners();
  }

  String? _phone;

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }

  UserRoleEnum? _role;

  UserRoleEnum? get role => _role;

  set role(UserRoleEnum? value) {
    _role = value;
    notifyListeners();
  }

  String? _hayalSube;

  String? get hayalSube => _hayalSube;

  set hayalSube(String? value) {
    _hayalSube = value;
    notifyListeners();
  }

  File? _image;

  File? get image => _image;

  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  String? _firebaseUserID;

  String? get firebaseUserID => _firebaseUserID;

  set firebaseUserID(String? value) {
    _firebaseUserID = value;
    notifyListeners();
  }

  String? _password;

  String? get password => _password;

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

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
}
