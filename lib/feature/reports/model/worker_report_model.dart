import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/feature/home/model/shop_by_user_model.dart';
import 'package:vexana/vexana.dart';
part 'worker_report_model.g.dart';

@JsonSerializable()
final class WorkerReportModel extends INetworkModel<WorkerReportModel> {
  const WorkerReportModel({this.date, this.distributorShops, this.day, this.user});
  @override
  factory WorkerReportModel.fromJson(Map<String, dynamic> json) {
    return _$WorkerReportModelFromJson(json);
  }
  final String? date;
  final List<ShopByUserModel>? distributorShops;
  final String? day;
  final UserModel? user;

  @override
  Map<String, dynamic> toJson() {
    return _$WorkerReportModelToJson(this);
  }

  @override
  WorkerReportModel fromJson(Map<String, dynamic> json) {
    return _$WorkerReportModelFromJson(json);
  }
}
