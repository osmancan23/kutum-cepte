import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:vexana/vexana.dart';
part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends INetworkModel<ShopModel> {
  const ShopModel({
    this.id,
    this.title,
    this.personName,
    this.description,
    this.boxCount,
    this.shopNo,
    this.shopStatus,
    this.boxStatus,
    this.shopPhotosUrl,
    this.sehirDto,
    this.ilceDto,
    this.latitudeCordinate,
    this.longitudeCordinate,
    this.firebaseShopID,
  });
  @override
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return _$ShopModelFromJson(json);
  }
  final int? id;
  final String? title;
  final String? personName;
  final String? description;
  final int? boxCount;
  final int? shopNo;
  final String? shopStatus;
  final String? boxStatus;
  final List<String>? shopPhotosUrl;
  final AddressModel? sehirDto;
  final AddressModel? ilceDto;
  final String? latitudeCordinate;
  final String? longitudeCordinate;
  final String? firebaseShopID;
  @override
  Map<String, dynamic> toJson() {
    return _$ShopModelToJson(this);
  }

  @override
  ShopModel fromJson(Map<String, dynamic> json) {
    return _$ShopModelFromJson(json);
  }
}
