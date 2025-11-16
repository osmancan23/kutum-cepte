// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_task_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminTaskDayModel _$AdminTaskDayModelFromJson(Map<String, dynamic> json) =>
    AdminTaskDayModel(
      date: json['date'] as String?,
      collectors: (json['collectors'] as List<dynamic>?)
          ?.map((e) => AdminTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      distributors: (json['distributors'] as List<dynamic>?)
          ?.map((e) => AdminTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      day: json['day'] as String?,
    );

Map<String, dynamic> _$AdminTaskDayModelToJson(AdminTaskDayModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'collectors': instance.collectors,
      'distributors': instance.distributors,
      'day': instance.day,
    };
