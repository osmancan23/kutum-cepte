import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:vexana/vexana.dart';
part 'shop_history_model.g.dart';

@JsonSerializable()

// ignore: must_be_immutable
class ShopHistoryModel extends INetworkModel<ShopHistoryModel> {
  ShopHistoryModel({
    this.id,
    this.userInfoDto,
    this.shopId,
    this.description,
    this.point,
    this.shopStatus,
    this.boxStatus,
    this.date,
    this.userId,
    this.isAgainBox,
  });
  @override
  factory ShopHistoryModel.fromJson(Map<String, dynamic> json) {
    return _$ShopHistoryModelFromJson(json);
  }
  int? id;
  UserModel? userInfoDto;
  int? shopId;
  String? description;
  int? point;
  String? shopStatus;
  String? boxStatus;
  String? date;
  String? userId;
  bool? isAgainBox;
  @override
  Map<String, dynamic> toJson() {
    return _$ShopHistoryModelToJson(this);
  }

  @override
  ShopHistoryModel fromJson(Map<String, dynamic> json) {
    return _$ShopHistoryModelFromJson(json);
  }
}
