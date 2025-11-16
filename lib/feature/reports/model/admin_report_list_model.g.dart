// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminReportListModel _$AdminReportListModelFromJson(
        Map<String, dynamic> json) =>
    AdminReportListModel(
      ilce: json['ilce'] == null
          ? null
          : AddressModel.fromJson(json['ilce'] as Map<String, dynamic>),
      sehir: json['sehir'] == null
          ? null
          : AddressModel.fromJson(json['sehir'] as Map<String, dynamic>),
      toplananKutu: (json['toplananKutu'] as num?)?.toInt(),
      toplamKutu: (json['toplamKutu'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdminReportListModelToJson(
        AdminReportListModel instance) =>
    <String, dynamic>{
      'ilce': instance.ilce,
      'sehir': instance.sehir,
      'toplananKutu': instance.toplananKutu,
      'toplamKutu': instance.toplamKutu,
    };
