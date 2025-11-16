// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopUpdateModel _$ShopUpdateModelFromJson(Map<String, dynamic> json) =>
    ShopUpdateModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      gsm: json['gsm'] as String?,
      personName: json['personName'] as String?,
      boxCount: (json['boxCount'] as num?)?.toInt(),
      shopNo: (json['shopNo'] as num?)?.toInt(),
      shopStatus: json['shopStatus'] as String?,
      boxStatus: json['boxStatus'] as String?,
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      latitudeCordinate: json['latitudeCordinate'] as String?,
      longitudeCordinate: json['longitudeCordinate'] as String?,
      firebaseShopID: json['firebaseShopID'] as String?,
      shopPhotosUrl: (json['shopPhotosUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ShopUpdateModelToJson(ShopUpdateModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'gsm': instance.gsm,
      'personName': instance.personName,
      'boxCount': instance.boxCount,
      'shopNo': instance.shopNo,
      'shopStatus': instance.shopStatus,
      'boxStatus': instance.boxStatus,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'latitudeCordinate': instance.latitudeCordinate,
      'longitudeCordinate': instance.longitudeCordinate,
      'shopPhotosUrl': instance.shopPhotosUrl,
      'firebaseShopID': instance.firebaseShopID,
    };
