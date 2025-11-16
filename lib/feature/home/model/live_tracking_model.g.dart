// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveTrackingModel _$LiveTrackingModelFromJson(Map<String, dynamic> json) =>
    LiveTrackingModel(
      collected: (json['collected'] as num?)?.toInt(),
      collectorTask: (json['collectorTask'] as List<dynamic>?)
          ?.map((e) => TaskShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notCollected: (json['notCollected'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LiveTrackingModelToJson(LiveTrackingModel instance) =>
    <String, dynamic>{
      'collected': instance.collected,
      'collectorTask': instance.collectorTask,
      'notCollected': instance.notCollected,
    };
