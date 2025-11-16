import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/feature/home/model/task_shop_model.dart';
import 'package:vexana/vexana.dart';
part 'live_tracking_model.g.dart';

@JsonSerializable()
final class LiveTrackingModel extends INetworkModel<LiveTrackingModel> {
  const LiveTrackingModel({this.collected, this.collectorTask, this.notCollected});
  @override
  factory LiveTrackingModel.fromJson(Map<String, dynamic> json) {
    return _$LiveTrackingModelFromJson(json);
  }
  final int? collected;
  final List<TaskShopModel>? collectorTask;
  final int? notCollected;
  @override
  Map<String, dynamic> toJson() {
    return _$LiveTrackingModelToJson(this);
  }

  @override
  LiveTrackingModel fromJson(Map<String, dynamic> json) {
    return _$LiveTrackingModelFromJson(json);
  }
}
