import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'create_distributor_task_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateDistributorTaskModel extends INetworkModel<CreateDistributorTaskModel> {
  CreateDistributorTaskModel({
    this.userId,
    this.adminUserId,
    this.taskDate,
    this.sehirId,
    this.ilceId,
    this.startTime,
    this.finishTime,
    this.sokaks,
  });

  @override
  factory CreateDistributorTaskModel.fromJson(Map<String, dynamic> json) {
    return _$CreateDistributorTaskModelFromJson(json);
  }
  int? userId;
  int? adminUserId;
  String? taskDate;
  int? sehirId;
  int? ilceId;
  String? startTime;
  String? finishTime;
  Map<String, bool>? sokaks;
  @override
  Map<String, dynamic> toJson() {
    return _$CreateDistributorTaskModelToJson(this);
  }

  @override
  CreateDistributorTaskModel fromJson(Map<String, dynamic> json) {
    return _$CreateDistributorTaskModelFromJson(json);
  }
}
