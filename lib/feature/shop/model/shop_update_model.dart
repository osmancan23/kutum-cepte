import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'shop_update_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ShopUpdateModel extends INetworkModel<ShopUpdateModel> {
  ShopUpdateModel({
    this.title,
    this.description,
    this.gsm,
    this.personName,
    this.boxCount,
    this.shopNo,
    this.shopStatus,
    this.boxStatus,
    this.sehirId,
    this.ilceId,
    this.latitudeCordinate,
    this.longitudeCordinate,
    this.firebaseShopID,
    this.shopPhotosUrl,
  });
  @override
  factory ShopUpdateModel.fromJson(Map<String, dynamic> json) {
    return _$ShopUpdateModelFromJson(json);
  }
  String? title;
  String? description;
  String? gsm;
  String? personName;
  int? boxCount;
  int? shopNo;
  String? shopStatus;
  String? boxStatus;
  int? sehirId;
  int? ilceId;
  String? latitudeCordinate;
  String? longitudeCordinate;
  List<String>? shopPhotosUrl;
  String? firebaseShopID;
  @override
  Map<String, dynamic> toJson() {
    return _$ShopUpdateModelToJson(this);
  }

  @override
  ShopUpdateModel fromJson(Map<String, dynamic> json) {
    return _$ShopUpdateModelFromJson(json);
  }
}
