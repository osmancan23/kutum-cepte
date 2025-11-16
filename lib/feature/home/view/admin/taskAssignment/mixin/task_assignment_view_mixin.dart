part of '../viewModel/task_assignment_view_model.dart';

mixin _TaskAssignmentViewMixin on IBaseViewModel {
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

  TaskType _taskType = TaskType.collector;

  TaskType get taskType => _taskType;

  set taskType(TaskType value) {
    _taskType = value;
    notifyListeners();
  }

  String _officerName = '';

  String get officerName => _officerName;

  set officerName(String value) {
    _officerName = value;
    notifyListeners();
  }

  DateTime? _date;

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
    notifyListeners();
  }

  int? _boxNoStart;

  int? get boxNoStart => _boxNoStart;

  set boxNoStart(int? value) {
    _boxNoStart = value;
    _handleMarkerType();
  }

  int? _boxNoEnd;

  int? get boxNoEnd => _boxNoEnd;

  set boxNoEnd(int? value) {
    _boxNoEnd = value;
    _handleMarkerType();
  }

  /// MARK: Handle marker type according to box no
  void _handleMarkerType() {
    // Gerekli koşulları kontrol et
    if (boxNoStart == null || boxNoEnd == null || locations.isEmpty) {
      return;
    }

    // Değişiklik olup olmadığını takip et
    var hasChanges = false;

    // Marker'ları toplu olarak işle
    final markersToUpdate = <MarkerModel>[];

    // İlk önce değişecek marker'ları belirle
    for (final element in locations) {
      if (element.shopNo != null &&
          element.markerType != MarkerType.completed &&
          element.markerType != MarkerType.active) {
        // Yeni marker tipini belirle
        final newType = (element.shopNo! >= boxNoStart! && element.shopNo! <= boxNoEnd!)
            ? MarkerType.selected
            : MarkerType.incompleted;

        // Sadece tip değiştiyse güncelle
        if (element.markerType != newType) {
          markersToUpdate.add(element);
          element.markerType = newType;
          hasChanges = true;
        }
      }
    }

    // Sadece değişiklik varsa notifyListeners çağır
    if (hasChanges) {
      log('${markersToUpdate.length} marker güncellendi');
      notifyListeners();
    }
  }

  String _startHour = '00:00';

  String get startHour => _startHour;

  set startHour(String value) {
    _startHour = value;
    notifyListeners();
  }

  String _endHour = '24:00';

  String get endHour => _endHour;

  set endHour(String value) {
    _endHour = value;
    notifyListeners();
  }

  int? _selectedUserId;

  int? get selectedUserId => _selectedUserId;

  set selectedUserId(int? value) {
    _selectedUserId = value;
    notifyListeners();
  }

  List<MarkerModel> _locations = [];

  List<MarkerModel> get locations => _locations;

  set locations(List<MarkerModel> value) {
    log('Gelen Locations: $value');
    _locations = value;

    // Locations değiştiğinde marker tiplerini güncelle
    if (boxNoStart != null && boxNoEnd != null) {
      _handleMarkerType();
    } else {
      notifyListeners();
    }
  }
}
