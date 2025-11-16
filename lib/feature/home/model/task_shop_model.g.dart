// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskShopModel _$TaskShopModelFromJson(Map<String, dynamic> json) =>
    TaskShopModel(
      taskId: (json['taskId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      shopByTaskCollectorDto: json['shopByTaskCollectorDto'] == null
          ? null
          : ShopByUserModel.fromJson(
              json['shopByTaskCollectorDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskShopModelToJson(TaskShopModel instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'isActive': instance.isActive,
      'shopByTaskCollectorDto': instance.shopByTaskCollectorDto,
    };
