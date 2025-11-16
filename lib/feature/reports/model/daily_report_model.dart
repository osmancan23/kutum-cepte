import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'daily_report_model.g.dart';

@JsonSerializable()
final class DailyReportModel extends INetworkModel<DailyReportModel> {
  DailyReportModel({
    this.userName,
    this.ilceName,
    this.totalKayipKutu,
    this.totalIade,
    this.totalKapaliDukkan,
    this.totalUniqueShopCount,
    this.totalDistributedBoxes,
    this.totalHoursWorked,
    this.avatarUrl,
  });
  @override
  factory DailyReportModel.fromJson(Map<String, dynamic> json) {
    return _$DailyReportModelFromJson(json);
  }
  String? userName;
  String? ilceName;
  int? totalKayipKutu;
  int? totalIade;
  int? totalKapaliDukkan;
  int? totalUniqueShopCount;
  int? totalDistributedBoxes;
  String? totalHoursWorked;
  String? avatarUrl;

  @override
  Map<String, dynamic> toJson() {
    return _$DailyReportModelToJson(this);
  }

  @override
  DailyReportModel fromJson(Map<String, dynamic> json) {
    return _$DailyReportModelFromJson(json);
  }
}
