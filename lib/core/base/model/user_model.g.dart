// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      sehirDto: json['sehirDto'] == null
          ? null
          : AddressModel.fromJson(json['sehirDto'] as Map<String, dynamic>),
      ilceDto: json['ilceDto'] == null
          ? null
          : AddressModel.fromJson(json['ilceDto'] as Map<String, dynamic>),
      firebaseUserID: json['firebaseUserID'] as String?,
      hayalSube: json['hayalSube'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'firebaseUserID': instance.firebaseUserID,
      'photoUrl': instance.photoUrl,
      'phone': instance.phone,
      'role': instance.role,
      'sehirDto': instance.sehirDto,
      'ilceDto': instance.ilceDto,
      'hayalSube': instance.hayalSube,
    };
