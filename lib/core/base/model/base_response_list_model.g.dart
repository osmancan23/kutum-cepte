// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseListModel<T>
    _$BaseResponseListModelFromJson<T extends INetworkModel<T>>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
        BaseResponseListModel<T>(
          parseModel: _$nullableGenericFromJson(json['parseModel'], fromJsonT),
          data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
          message: json['message'] as String?,
          status: json['status'] as String?,
        );

Map<String, dynamic> _$BaseResponseListModelToJson<T extends INetworkModel<T>>(
  BaseResponseListModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data?.map(toJsonT).toList(),
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
