// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopHistoryModel _$ShopHistoryModelFromJson(Map<String, dynamic> json) =>
    ShopHistoryModel(
      id: (json['id'] as num?)?.toInt(),
      userInfoDto: json['userInfoDto'] == null
          ? null
          : UserModel.fromJson(json['userInfoDto'] as Map<String, dynamic>),
      shopId: (json['shopId'] as num?)?.toInt(),
      description: json['description'] as String?,
      point: (json['point'] as num?)?.toInt(),
      shopStatus: json['shopStatus'] as String?,
      boxStatus: json['boxStatus'] as String?,
      date: json['date'] as String?,
      userId: json['userId'] as String?,
      isAgainBox: json['isAgainBox'] as bool?,
    );

Map<String, dynamic> _$ShopHistoryModelToJson(ShopHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfoDto': instance.userInfoDto,
      'shopId': instance.shopId,
      'description': instance.description,
      'point': instance.point,
      'shopStatus': instance.shopStatus,
      'boxStatus': instance.boxStatus,
      'date': instance.date,
      'userId': instance.userId,
      'isAgainBox': instance.isAgainBox,
    };
