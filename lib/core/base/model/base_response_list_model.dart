import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'base_response_list_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
final class BaseResponseListModel<T extends INetworkModel<T>> extends INetworkModel<BaseResponseListModel<T>> {
  const BaseResponseListModel({required this.parseModel, this.data, this.message, this.status});
  final String? message;
  final List<T>? data;
  final String? status;
  final T? parseModel;

  T fromJsonT(Object? json) {
    return parseModel!.fromJson(json! as Map<String, dynamic>);
  }

  Object? toJsonT(T data) {
    return data.toJson();
  }

  @override
  BaseResponseListModel<T> fromJson(Map<String, dynamic> json) {
    return _$BaseResponseListModelFromJson(json, fromJsonT);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$BaseResponseListModelToJson(this, toJsonT);
  }
}
