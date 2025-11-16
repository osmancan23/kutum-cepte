// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_by_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopByUserModel _$ShopByUserModelFromJson(Map<String, dynamic> json) =>
    ShopByUserModel(
      shopStatus: json['shopStatus'] as String?,
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      shopNo: (json['shopNo'] as num?)?.toInt(),
      latitudeCordinate: json['latitudeCordinate'] as String?,
      longitudeCordinate: json['longitudeCordinate'] as String?,
      sehirDto: json['sehirDto'] == null
          ? null
          : AddressModel.fromJson(json['sehirDto'] as Map<String, dynamic>),
      ilceDto: json['ilceDto'] == null
          ? null
          : AddressModel.fromJson(json['ilceDto'] as Map<String, dynamic>),
      boxCount: (json['boxCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopByUserModelToJson(ShopByUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shopNo': instance.shopNo,
      'shopStatus': instance.shopStatus,
      'latitudeCordinate': instance.latitudeCordinate,
      'longitudeCordinate': instance.longitudeCordinate,
      'sehirDto': instance.sehirDto,
      'ilceDto': instance.ilceDto,
      'boxCount': instance.boxCount,
    };
