// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_and_create_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAndCreateUserModel _$UpdateAndCreateUserModelFromJson(
        Map<String, dynamic> json) =>
    UpdateAndCreateUserModel(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      sehirId: (json['sehirId'] as num?)?.toInt(),
      ilceId: (json['ilceId'] as num?)?.toInt(),
      hayalSube: json['hayalSube'] as String?,
      firebaseUserID: json['firebaseUserID'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UpdateAndCreateUserModelToJson(
        UpdateAndCreateUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'photoUrl': instance.photoUrl,
      'phone': instance.phone,
      'password': instance.password,
      'hayalSube': instance.hayalSube,
      'sehirId': instance.sehirId,
      'ilceId': instance.ilceId,
      'firebaseUserID': instance.firebaseUserID,
      'role': instance.role,
    };
