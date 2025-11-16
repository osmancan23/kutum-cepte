import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'shop_create_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ShopCreateModel extends INetworkModel<ShopCreateModel> {
  ShopCreateModel({
    this.title,
    this.description,
    this.boxCount,
    this.shopPhotosUrl,
    this.sehirId,
    this.ilceId,
    // this.mahalleId,
    this.latitudeCordinate,
    this.longitudeCordinate,
    this.firebaseShopID,
    this.createUserId,
    this.createDate,
  });
  @override
  factory ShopCreateModel.fromJson(Map<String, dynamic> json) {
    return _$ShopCreateModelFromJson(json);
  }
  String? title;
  String? description;
  int? boxCount;
  List<String>? shopPhotosUrl;
  int? sehirId;
  int? ilceId;
  // int? mahalleId;
  double? latitudeCordinate;
  double? longitudeCordinate;
  String? firebaseShopID;
  int? createUserId;
  String? createDate;
  @override
  Map<String, dynamic> toJson() {
    return _$ShopCreateModelToJson(this);
  }

  @override
  ShopCreateModel fromJson(Map<String, dynamic> json) {
    return _$ShopCreateModelFromJson(json);
  }
}
