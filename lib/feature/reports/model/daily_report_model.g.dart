// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReportModel _$DailyReportModelFromJson(Map<String, dynamic> json) =>
    DailyReportModel(
      userName: json['userName'] as String?,
      ilceName: json['ilceName'] as String?,
      totalKayipKutu: (json['totalKayipKutu'] as num?)?.toInt(),
      totalIade: (json['totalIade'] as num?)?.toInt(),
      totalKapaliDukkan: (json['totalKapaliDukkan'] as num?)?.toInt(),
      totalUniqueShopCount: (json['totalUniqueShopCount'] as num?)?.toInt(),
      totalDistributedBoxes: (json['totalDistributedBoxes'] as num?)?.toInt(),
      totalHoursWorked: json['totalHoursWorked'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$DailyReportModelToJson(DailyReportModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'ilceName': instance.ilceName,
      'totalKayipKutu': instance.totalKayipKutu,
      'totalIade': instance.totalIade,
      'totalKapaliDukkan': instance.totalKapaliDukkan,
      'totalUniqueShopCount': instance.totalUniqueShopCount,
      'totalDistributedBoxes': instance.totalDistributedBoxes,
      'totalHoursWorked': instance.totalHoursWorked,
      'avatarUrl': instance.avatarUrl,
    };
