import 'package:kutum_cepte_app/core/base/model/address_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_list_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:vexana/vexana.dart';

abstract class IAdressService {
  IAdressService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  Future<List<AddressModel>> fetchCities();
  Future<List<AddressModel>> fetchDistricts(int cityId);
}

class AddressService extends IAdressService {
  AddressService();

  @override
  Future<List<AddressModel>> fetchCities() async {
    final response =
        await _networkManager.send<BaseResponseListModel<AddressModel>, BaseResponseListModel<AddressModel>>(
      NetworkEnums.cities.key,
      parseModel: const BaseResponseListModel(parseModel: AddressModel()),
      method: RequestType.GET,
      
    );

    return response.data?.data ?? [];
  }

  @override
  Future<List<AddressModel>> fetchDistricts(int cityId) async {
    final response =
        await _networkManager.send<BaseResponseListModel<AddressModel>, BaseResponseListModel<AddressModel>>(
      NetworkEnums.districts.key + cityId.toString(),
      parseModel: const BaseResponseListModel(parseModel: AddressModel()),
      method: RequestType.GET,
    );

    return response.data?.data ?? [];
  }

 
}
