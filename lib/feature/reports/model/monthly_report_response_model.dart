import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'monthly_report_response_model.g.dart';

@JsonSerializable()
class MonthlyReportResponseModel extends INetworkModel<MonthlyReportResponseModel> {
  MonthlyReportResponseModel({this.toplanmayan, this.toplanan, this.hedef});
  @override
  factory MonthlyReportResponseModel.fromJson(Map<String, dynamic> json) {
    return _$MonthlyReportResponseModelFromJson(json);
  }
  int? toplanmayan;
  int? toplanan;
  int? hedef;
  @override
  Map<String, dynamic> toJson() {
    return _$MonthlyReportResponseModelToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$MonthlyReportResponseModelFromJson(json);
  }
}
