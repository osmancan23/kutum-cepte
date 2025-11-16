// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_report_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyReportResponseModel _$MonthlyReportResponseModelFromJson(
        Map<String, dynamic> json) =>
    MonthlyReportResponseModel(
      toplanmayan: (json['toplanmayan'] as num?)?.toInt(),
      toplanan: (json['toplanan'] as num?)?.toInt(),
      hedef: (json['hedef'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MonthlyReportResponseModelToJson(
        MonthlyReportResponseModel instance) =>
    <String, dynamic>{
      'toplanmayan': instance.toplanmayan,
      'toplanan': instance.toplanan,
      'hedef': instance.hedef,
    };
