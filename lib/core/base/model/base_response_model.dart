import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T extends INetworkModel<T>> extends INetworkModel<BaseResponseModel<T>> {
  const BaseResponseModel({required this.parseModel, this.data, this.message, this.status});
  final String? message;
  final T? data;
  final String? status;
  final T? parseModel;

  T fromJsonT(Object? json) {
    return parseModel!.fromJson(json! as Map<String, dynamic>);
  }

  Object? toJsonT(T data) {
    return data.toJson();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$BaseResponseModelToJson(this, toJsonT);
  }

  @override
  BaseResponseModel<T> fromJson(Map<String, dynamic> json) {
    return _$BaseResponseModelFromJson(json, fromJsonT);
  }
}
