import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends INetworkModel<AddressModel> {
  const AddressModel({this.id, this.title});
  @override
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return _$AddressModelFromJson(json);
  }
  final int? id;
  final String? title;
  @override
  Map<String, dynamic> toJson() {
    return _$AddressModelToJson(this);
  }

  @override
  AddressModel fromJson(Map<String, dynamic> json) {
    return _$AddressModelFromJson(json);
  }
}


