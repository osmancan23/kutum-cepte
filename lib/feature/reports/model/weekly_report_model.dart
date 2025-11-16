import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'weekly_report_model.g.dart';

@JsonSerializable()
class WeeklyReportModel extends INetworkModel<WeeklyReportModel> {
  WeeklyReportModel({
    this.name,
    this.necisin,
    this.createDate,
    this.surname,
    this.sehirId,
    this.ilceId,
    this.userId,
    this.photoUrl,
  });
  @override
  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) {
    return _$WeeklyReportModelFromJson(json);
  }
  String? name;
  String? necisin;
  String? createDate;
  String? surname;
  int? sehirId;
  int? ilceId;
  int? userId;
  String? photoUrl;
  @override
  Map<String, dynamic> toJson() {
    return _$WeeklyReportModelToJson(this);
  }

  @override
  WeeklyReportModel fromJson(Map<String, dynamic> json) {
    return _$WeeklyReportModelFromJson(json);
  }
}
