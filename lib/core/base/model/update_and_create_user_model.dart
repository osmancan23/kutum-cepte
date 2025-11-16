import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'update_and_create_user_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class UpdateAndCreateUserModel extends INetworkModel<UpdateAndCreateUserModel> {
  UpdateAndCreateUserModel({
    this.name,
    this.surname,
    this.photoUrl,
    this.phone,
    this.password,
    this.sehirId,
    this.ilceId,
    this.hayalSube,
    this.firebaseUserID,
    this.role,
  });
  @override
  factory UpdateAndCreateUserModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateAndCreateUserModelFromJson(json);
  }
  String? name;
  String? surname;
  String? photoUrl;
  String? phone;
  String? password;
  String? hayalSube;
  int? sehirId;
  int? ilceId;
  String? firebaseUserID;
  String? role;
  @override
  Map<String, dynamic> toJson() {
    return _$UpdateAndCreateUserModelToJson(this);
  }

  @override
  UpdateAndCreateUserModel fromJson(Map<String, dynamic> json) {
    return _$UpdateAndCreateUserModelFromJson(json);
  }
}
