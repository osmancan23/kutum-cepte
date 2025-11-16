import 'package:flutter/material.dart';

class MarkerModel {
  MarkerModel({
    this.id,
    this.latitude,
    this.longitude,
    this.title,
    this.cityName,
    this.districtName,
    this.markerType = MarkerType.incompleted,
    this.shopNo,
    this.taskId,
  });
  String? id;
  double? latitude;
  double? longitude;
  String? title;
  String? cityName;
  String? districtName;
  MarkerType markerType;
  int? shopNo;
  int? taskId;
}

enum MarkerType {
  ///MARK: Complete Task Marker
  completed(color: Colors.green),

  ///MARK: Incompleted Task Marker(Initial Color)
  incompleted(color: Colors.blue),

  ///MARK: Selected Task Marker
  selected(color: Colors.red),

  ///MARK: Active Task Marker
  active(color: Colors.yellow);

  const MarkerType({required this.color});

  final Color color;

  static MarkerType handleMarkerType(String? status) {
    if (status == 'AKTIF') {
      return MarkerType.active;
    } else if (status == 'TOPLANDI') {
      return MarkerType.completed;
    } else {
      return MarkerType.incompleted;
    }
  }
}
