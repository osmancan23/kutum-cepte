import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:vexana/vexana.dart';
part 'shop_by_user_model.g.dart';

@JsonSerializable()
final class ShopByUserModel extends INetworkModel<ShopByUserModel> {
  const ShopByUserModel({
    this.shopStatus,
    this.id,
    this.title,
    this.shopNo,
    this.latitudeCordinate,
    this.longitudeCordinate,
    this.sehirDto,
    this.ilceDto,
    this.boxCount,
  });
  @override
  factory ShopByUserModel.fromJson(Map<String, dynamic> json) {
    return _$ShopByUserModelFromJson(json);
  }
  final int? id;
  final String? title;
  final int? shopNo;
  final String? shopStatus;
  final String? latitudeCordinate;
  final String? longitudeCordinate;
  // Only For Worker Report
  final AddressModel? sehirDto;
  final AddressModel? ilceDto;
  final int? boxCount;

  @override
  Map<String, dynamic> toJson() {
    return _$ShopByUserModelToJson(this);
  }

  @override
  ShopByUserModel fromJson(Map<String, dynamic> json) {
    return _$ShopByUserModelFromJson(json);
  }
}
