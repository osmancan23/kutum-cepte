// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_distributor_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDistributorTaskModel _$CreateDistributorTaskModelFromJson(
        Map<String, dynamic> json) =>
    CreateDistributorTaskModel(
      userId: (json['userId'] as num?)?.toInt(),
      adminUserId: (json['adminUserId'] as num?)?.toInt(),
      taskDate: json['taskDate'] as String?,
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      startTime: json['startTime'] as String?,
      finishTime: json['finishTime'] as String?,
      sokaks: (json['sokaks'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
    );

Map<String, dynamic> _$CreateDistributorTaskModelToJson(
        CreateDistributorTaskModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'adminUserId': instance.adminUserId,
      'taskDate': instance.taskDate,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'startTime': instance.startTime,
      'finishTime': instance.finishTime,
      'sokaks': instance.sokaks,
    };
