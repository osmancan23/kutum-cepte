// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      personName: json['personName'] as String?,
      description: json['description'] as String?,
      boxCount: (json['boxCount'] as num?)?.toInt(),
      shopNo: (json['shopNo'] as num?)?.toInt(),
      shopStatus: json['shopStatus'] as String?,
      boxStatus: json['boxStatus'] as String?,
      shopPhotosUrl: (json['shopPhotosUrl'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sehirDto: json['sehirDto'] == null
          ? null
          : AddressModel.fromJson(json['sehirDto'] as Map<String, dynamic>),
      ilceDto: json['ilceDto'] == null
          ? null
          : AddressModel.fromJson(json['ilceDto'] as Map<String, dynamic>),
      latitudeCordinate: json['latitudeCordinate'] as String?,
      longitudeCordinate: json['longitudeCordinate'] as String?,
      firebaseShopID: json['firebaseShopID'] as String?,
    );

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'personName': instance.personName,
      'description': instance.description,
      'boxCount': instance.boxCount,
      'shopNo': instance.shopNo,
      'shopStatus': instance.shopStatus,
      'boxStatus': instance.boxStatus,
      'shopPhotosUrl': instance.shopPhotosUrl,
      'sehirDto': instance.sehirDto,
      'ilceDto': instance.ilceDto,
      'latitudeCordinate': instance.latitudeCordinate,
      'longitudeCordinate': instance.longitudeCordinate,
      'firebaseShopID': instance.firebaseShopID,
    };
