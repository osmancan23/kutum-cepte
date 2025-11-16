import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:vexana/vexana.dart';
part 'distributor_task_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
final class DistributorTaskModel extends INetworkModel<DistributorTaskModel> {
  DistributorTaskModel({
    this.id,
    this.userInfoDto,
    this.adminUserInfoDto,
    this.sokaks,
    this.sehirDto,
    this.ilceDto,
    this.taskDate,
    this.time,
    this.isActive,
    this.startTime,
    this.finishTime,
  });
  @override
  factory DistributorTaskModel.fromJson(Map<String, dynamic> json) {
    return _$DistributorTaskModelFromJson(json);
  }
  final int? id;
  final UserModel? userInfoDto;
  final UserModel? adminUserInfoDto;
  Map<String, bool>? sokaks;
  final AddressModel? sehirDto;
  final AddressModel? ilceDto;
  final String? taskDate;
  final double? time;
  final bool? isActive;
  final String? startTime;
  final String? finishTime;
  @override
  Map<String, dynamic> toJson() {
    return _$DistributorTaskModelToJson(this);
  }

  @override
  DistributorTaskModel fromJson(Map<String, dynamic> json) {
    return _$DistributorTaskModelFromJson(json);
  }
}
