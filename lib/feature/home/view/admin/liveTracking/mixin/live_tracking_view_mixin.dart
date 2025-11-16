part of '../viewModel/live_tracking_view_model.dart';

mixin _LiveTrackingViewMixin on IBaseViewModel {
  int? _cityId;

  int? get cityId => _cityId;

  set cityId(int? value) {
    _cityId = value;
    notifyListeners();
  }

  int? _districtId;

  int? get districtId => _districtId;

  set districtId(int? value) {
    _districtId = value;
    notifyListeners();
  }


  List<MarkerModel>? _markers;

  List<MarkerModel>? get markers => _markers;

  set markers(List<MarkerModel>? value) {
    _markers = value;
    notifyListeners();
  }

  int? _collectedPercent;

  int? get collectedPercent => _collectedPercent;

  set collectedPercent(int? value) {
    _collectedPercent = value;
    notifyListeners();
  }

  int? _waitingPercent;

  int? get waitingPercent => _waitingPercent;

  set waitingPercent(int? value) {
    _waitingPercent = value;
    notifyListeners();
  }

  DateTime? _date;

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
    notifyListeners();
  }
}
