// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyReportModel _$WeeklyReportModelFromJson(Map<String, dynamic> json) =>
    WeeklyReportModel(
      name: json['name'] as String?,
      necisin: json['necisin'] as String?,
      createDate: json['createDate'] as String?,
      surname: json['surname'] as String?,
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$WeeklyReportModelToJson(WeeklyReportModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'necisin': instance.necisin,
      'createDate': instance.createDate,
      'surname': instance.surname,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'userId': instance.userId,
      'photoUrl': instance.photoUrl,
    };
