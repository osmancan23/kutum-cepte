// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_task_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectorTaskResponseModel _$CollectorTaskResponseModelFromJson(
        Map<String, dynamic> json) =>
    CollectorTaskResponseModel(
      taskShops: (json['taskShops'] as List<dynamic>?)
          ?.map((e) => TaskShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ilce: json['ilce'] == null
          ? null
          : AddressModel.fromJson(json['ilce'] as Map<String, dynamic>),
      adminUser: json['adminUser'] == null
          ? null
          : UserModel.fromJson(json['adminUser'] as Map<String, dynamic>),
      taskDate: json['taskDate'] as String?,
      shopsCount: (json['shopsCount'] as num?)?.toInt(),
      sehir: json['sehir'] == null
          ? null
          : AddressModel.fromJson(json['sehir'] as Map<String, dynamic>),
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
    );

Map<String, dynamic> _$CollectorTaskResponseModelToJson(
        CollectorTaskResponseModel instance) =>
    <String, dynamic>{
      'taskShops': instance.taskShops,
      'ilce': instance.ilce,
      'adminUser': instance.adminUser,
      'taskDate': instance.taskDate,
      'shopsCount': instance.shopsCount,
      'sehir': instance.sehir,
      'userName': instance.userName,
      'userSurname': instance.userSurname,
    };
