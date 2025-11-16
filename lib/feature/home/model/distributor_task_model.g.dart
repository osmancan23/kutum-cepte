// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distributor_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributorTaskModel _$DistributorTaskModelFromJson(
        Map<String, dynamic> json) =>
    DistributorTaskModel(
      id: (json['id'] as num?)?.toInt(),
      userInfoDto: json['userInfoDto'] == null
          ? null
          : UserModel.fromJson(json['userInfoDto'] as Map<String, dynamic>),
      adminUserInfoDto: json['adminUserInfoDto'] == null
          ? null
          : UserModel.fromJson(
              json['adminUserInfoDto'] as Map<String, dynamic>),
      sokaks: (json['sokaks'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      sehirDto: json['sehirDto'] == null
          ? null
          : AddressModel.fromJson(json['sehirDto'] as Map<String, dynamic>),
      ilceDto: json['ilceDto'] == null
          ? null
          : AddressModel.fromJson(json['ilceDto'] as Map<String, dynamic>),
      taskDate: json['taskDate'] as String?,
      time: (json['time'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      startTime: json['startTime'] as String?,
      finishTime: json['finishTime'] as String?,
    );

Map<String, dynamic> _$DistributorTaskModelToJson(
        DistributorTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfoDto': instance.userInfoDto,
      'adminUserInfoDto': instance.adminUserInfoDto,
      'sokaks': instance.sokaks,
      'sehirDto': instance.sehirDto,
      'ilceDto': instance.ilceDto,
      'taskDate': instance.taskDate,
      'time': instance.time,
      'isActive': instance.isActive,
      'startTime': instance.startTime,
      'finishTime': instance.finishTime,
    };
