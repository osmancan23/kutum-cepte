import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:vexana/vexana.dart';
part 'admin_report_list_model.g.dart';

@JsonSerializable()
final class AdminReportListModel extends INetworkModel<AdminReportListModel> {
  const AdminReportListModel({this.ilce, this.sehir, this.toplananKutu, this.toplamKutu});
  @override
  factory AdminReportListModel.fromJson(Map<String, dynamic> json) {
    return _$AdminReportListModelFromJson(json);
  }
  final AddressModel? ilce;
  final AddressModel? sehir;
  final int? toplananKutu;
  final int? toplamKutu;
  @override
  Map<String, dynamic> toJson() {
    return _$AdminReportListModelToJson(this);
  }

  @override
  AdminReportListModel fromJson(Map<String, dynamic> json) {
    return _$AdminReportListModelFromJson(json);
  }
}
