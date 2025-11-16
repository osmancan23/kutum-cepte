import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
final class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  const LoginResponseModel({this.status, this.message, this.data});
  @override
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
  final String? status;
  final String? message;
  final String? data;
  @override
  Map<String, dynamic> toJson() {
    return _$LoginResponseModelToJson(this);
  }

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
}
