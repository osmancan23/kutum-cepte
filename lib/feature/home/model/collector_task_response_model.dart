import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/feature/home/model/task_shop_model.dart';
import 'package:vexana/vexana.dart';
part 'collector_task_response_model.g.dart';

@JsonSerializable()
final class CollectorTaskResponseModel extends INetworkModel<CollectorTaskResponseModel> {
  const CollectorTaskResponseModel({
    this.taskShops,
    this.ilce,
    this.adminUser,
    this.taskDate,
    this.shopsCount,
    this.sehir,
    this.userName,
    this.userSurname,
  });
  @override
  factory CollectorTaskResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CollectorTaskResponseModelFromJson(json);
  }
  final List<TaskShopModel>? taskShops;
  final AddressModel? ilce;
  final UserModel? adminUser;
  final String? taskDate;
  final int? shopsCount;
  final AddressModel? sehir;
  final String? userName;
  final String? userSurname;
  @override
  Map<String, dynamic> toJson() {
    return _$CollectorTaskResponseModelToJson(this);
  }

  @override
  CollectorTaskResponseModel fromJson(Map<String, dynamic> json) {
    return _$CollectorTaskResponseModelFromJson(json);
  }
}
