import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:vexana/vexana.dart';
part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel extends INetworkModel<UserModel> {
  const UserModel({
    this.id,
    this.name,
    this.surname,
    this.photoUrl,
    this.phone,
    this.role,
    this.sehirDto,
    this.ilceDto,
    this.firebaseUserID,
    this.hayalSube,
  });
  @override
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }
  final int? id;
  final String? name;
  final String? surname;
  final String? firebaseUserID;
  final String? photoUrl;
  final String? phone;
  final String? role;
  final AddressModel? sehirDto;
  final AddressModel? ilceDto;
  final String? hayalSube;

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }
}
