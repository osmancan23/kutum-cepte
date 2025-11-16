import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'base_error_model.g.dart';

@JsonSerializable()
final class BaseModel extends INetworkModel<BaseModel> {
  const BaseModel({this.message, this.status});
  @override
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return _$BaseModelFromJson(json);
  }
  final String? message;
  final String? status;

  bool get isSuccess => status == 'success';

  @override
  Map<String, dynamic> toJson() {
    return _$BaseModelToJson(this);
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return _$BaseModelFromJson(json);
  }
}
