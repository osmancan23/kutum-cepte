// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_collector_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCollectorTaskModel _$CreateCollectorTaskModelFromJson(
        Map<String, dynamic> json) =>
    CreateCollectorTaskModel(
      userId: (json['userId'] as num?)?.toInt(),
      adminUserId: (json['adminUserId'] as num?)?.toInt(),
      taskDate: json['taskDate'] as String?,
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      minShopNo: (json['minShopNo'] as num?)?.toInt(),
      maxShopNo: (json['maxShopNo'] as num?)?.toInt(),
      startTime: json['startTime'] as String?,
      finishTime: json['finishTime'] as String?,
    );

Map<String, dynamic> _$CreateCollectorTaskModelToJson(
        CreateCollectorTaskModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'adminUserId': instance.adminUserId,
      'taskDate': instance.taskDate,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'minShopNo': instance.minShopNo,
      'maxShopNo': instance.maxShopNo,
      'startTime': instance.startTime,
      'finishTime': instance.finishTime,
    };
