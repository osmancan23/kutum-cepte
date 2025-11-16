// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerReportModel _$WorkerReportModelFromJson(Map<String, dynamic> json) =>
    WorkerReportModel(
      date: json['date'] as String?,
      distributorShops: (json['distributorShops'] as List<dynamic>?)
          ?.map((e) => ShopByUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      day: json['day'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkerReportModelToJson(WorkerReportModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'distributorShops': instance.distributorShops,
      'day': instance.day,
      'user': instance.user,
    };
