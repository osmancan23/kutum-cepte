import 'package:json_annotation/json_annotation.dart';
import 'package:kutum_cepte_app/feature/home/model/shop_by_user_model.dart';
import 'package:vexana/vexana.dart';
part 'task_shop_model.g.dart';

@JsonSerializable()
final class TaskShopModel extends INetworkModel<TaskShopModel> {
  const TaskShopModel({this.taskId, this.isActive, this.shopByTaskCollectorDto});
  @override
  factory TaskShopModel.fromJson(Map<String, dynamic> json) {
    return _$TaskShopModelFromJson(json);
  }
  final int? taskId;
  final bool? isActive;
  final ShopByUserModel? shopByTaskCollectorDto;
  @override
  Map<String, dynamic> toJson() {
    return _$TaskShopModelToJson(this);
  }

  @override
  TaskShopModel fromJson(Map<String, dynamic> json) {
    return _$TaskShopModelFromJson(json);
  }
}
