// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
