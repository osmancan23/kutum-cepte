import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'create_collector_task_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateCollectorTaskModel extends INetworkModel<CreateCollectorTaskModel> {
  CreateCollectorTaskModel({
    this.userId,
    this.adminUserId,
    this.taskDate,
    this.sehirId,
    this.ilceId,
    this.minShopNo,
    this.maxShopNo,
    this.startTime,
    this.finishTime,
  });
  @override
  factory CreateCollectorTaskModel.fromJson(Map<String, dynamic> json) {
    return _$CreateCollectorTaskModelFromJson(json);
  }
  int? userId;
  int? adminUserId;
  String? taskDate;
  int? sehirId;
  int? ilceId;
  int? minShopNo;
  int? maxShopNo;
  String? startTime;
  String? finishTime;
  @override
  Map<String, dynamic> toJson() {
    return _$CreateCollectorTaskModelToJson(this);
  }

  @override
  CreateCollectorTaskModel fromJson(Map<String, dynamic> json) {
    return _$CreateCollectorTaskModelFromJson(json);
  }
}
