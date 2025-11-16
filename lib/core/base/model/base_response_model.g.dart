// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel<T> _$BaseResponseModelFromJson<T extends INetworkModel<T>>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponseModel<T>(
      parseModel: _$nullableGenericFromJson(json['parseModel'], fromJsonT),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BaseResponseModelToJson<T extends INetworkModel<T>>(
  BaseResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'status': instance.status,
      'parseModel': _$nullableGenericToJson(instance.parseModel, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
