import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'admin_task_day_model.g.dart';

@JsonSerializable()
class AdminTaskDayModel extends INetworkModel<AdminTaskDayModel> {
  const AdminTaskDayModel({this.date, this.collectors, this.distributors, this.day});
  @override
  factory AdminTaskDayModel.fromJson(Map<String, dynamic> json) {
    return _$AdminTaskDayModelFromJson(json);
  }
  final String? date;
  // ignore: library_private_types_in_public_api
  final List<AdminTaskModel>? collectors;
  // ignore: library_private_types_in_public_api
  final List<AdminTaskModel>? distributors;
  final String? day;

  @override
  Map<String, dynamic> toJson() {
    return _$AdminTaskDayModelToJson(this);
  }

  @override
  AdminTaskDayModel fromJson(Map<String, dynamic> json) {
    return _$AdminTaskDayModelFromJson(json);
  }
}

class AdminTaskModel {
  AdminTaskModel({
    this.userId,
    this.userName,
    this.userSurname,
    this.sehir,
    this.sehirId,
    this.ilce,
    this.ilceId,
    this.taskCount,
    this.taskId,
  });

  AdminTaskModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as int?;
    userName = json['userName'] as String?;
    userSurname = json['userSurname'] as String?;
    sehir = json['sehir'] as String?;
    sehirId = json['sehirId'] as int?;
    ilce = json['ilce'] as String?;
    ilceId = json['ilceId'] as int?;
    taskCount = json['taskCount'] as int?;
    taskId = json['taskId'] as int?;
  }
  int? userId;
  String? userName;
  String? userSurname;
  String? sehir;
  int? sehirId;
  String? ilce;
  int? ilceId;
  int? taskCount;
  int? taskId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['userSurname'] = userSurname;
    data['sehir'] = sehir;
    data['sehirId'] = sehirId;
    data['ilce'] = ilce;
    data['ilceId'] = ilceId;
    data['taskCount'] = taskCount;
    data['taskId'] = taskId;
    return data;
  }
}
