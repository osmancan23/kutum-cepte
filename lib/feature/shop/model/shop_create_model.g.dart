// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCreateModel _$ShopCreateModelFromJson(Map<String, dynamic> json) =>
    ShopCreateModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      boxCount: (json['boxCount'] as num?)?.toInt(),
      shopPhotosUrl: (json['shopPhotosUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      latitudeCordinate: (json['latitudeCordinate'] as num?)?.toDouble(),
      longitudeCordinate: (json['longitudeCordinate'] as num?)?.toDouble(),
      firebaseShopID: json['firebaseShopID'] as String?,
      createUserId: (json['createUserId'] as num?)?.toInt(),
      createDate: json['createDate'] as String?,
    );

Map<String, dynamic> _$ShopCreateModelToJson(ShopCreateModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'boxCount': instance.boxCount,
      'shopPhotosUrl': instance.shopPhotosUrl,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'latitudeCordinate': instance.latitudeCordinate,
      'longitudeCordinate': instance.longitudeCordinate,
      'firebaseShopID': instance.firebaseShopID,
      'createUserId': instance.createUserId,
      'createDate': instance.createDate,
    };
