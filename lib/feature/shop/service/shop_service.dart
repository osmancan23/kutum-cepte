import 'package:kutum_cepte_app/core/base/model/base_error_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_list_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_create_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_history_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_update_model.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:kutum_cepte_app/utils/typedefs/typedefs.dart';
import 'package:vexana/vexana.dart';

abstract class IShopService {
  IShopService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  Future<List<ShopModel>> fetchAllShops({required int sehirId, required int ilceId});

  Future<ShopModel?> fetchShopDetail(int id);

  Future<BaseResult> createShop(ShopCreateModel model);

  Future<BaseResult> updateShop(int id, ShopUpdateModel model);

  Future<BaseResult> deleteShop(int id);
  Future<BaseResult> resetShops(int sehirId);


  Future<BaseResult> changeShopNo({required int shopId, required int newShopNo});

  // SHOP HISTORY

  Future<List<ShopHistoryModel>> fetchShopHistoryById({required int shopId});

  Future<BaseResult> createShopHistory(ShopHistoryModel model);

  Future<List<ShopHistoryModel>> fetchAllShopHistories();
}

class ShopService extends IShopService {
  @override
  Future<List<ShopModel>> fetchAllShops({required int sehirId, required int ilceId}) async {
    final response = await _networkManager.send<BaseResponseListModel<ShopModel>, BaseResponseListModel<ShopModel>>(
      NetworkEnums.shopAll.key,
      parseModel: const BaseResponseListModel(parseModel: ShopModel()),
      method: RequestType.POST,
      data: {
        'sehirId': sehirId,
        'ilceId': ilceId,
      },
    );

    return response.data?.data ?? [];
  }

  @override
  Future<ShopModel?> fetchShopDetail(int id) async {
    final response = await _networkManager.send<BaseResponseModel<ShopModel>, BaseResponseModel<ShopModel>>(
      NetworkEnums.shopById.key + id.toString(),
      parseModel: const BaseResponseModel(parseModel: ShopModel()),
      method: RequestType.GET,
    );

    return response.data?.data;
  }

  @override
  Future<BaseResult> changeShopNo({required int shopId, required int newShopNo}) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.changeShopNo.key,
      parseModel: const BaseModel(),
      method: RequestType.GET,
      queryParameters: {
        'shopId': shopId,
        'shopNo': newShopNo,
      },
    );

    return response;
  }

  @override
  Future<BaseResult> createShop(ShopCreateModel model) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.createShop.key,
      parseModel: const BaseModel(),
      method: RequestType.POST,
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<BaseResult> deleteShop(int id) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.deleteShop.key + id.toString(),
      parseModel: const BaseModel(),
      method: RequestType.DELETE,
    );

    return response;
  }

  @override
  Future<BaseResult> updateShop(int id, ShopUpdateModel model) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.updateShop.key + id.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<BaseResult> createShopHistory(ShopHistoryModel model) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.createShopHistory.key,
      parseModel: const BaseModel(),
      method: RequestType.POST,
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<List<ShopHistoryModel>> fetchAllShopHistories() async {
    final response =
        await _networkManager.send<BaseResponseListModel<ShopHistoryModel>, BaseResponseListModel<ShopHistoryModel>>(
      NetworkEnums.shopHistoryAll.key,
      parseModel: BaseResponseListModel(parseModel: ShopHistoryModel()),
      method: RequestType.GET,
    );

    return response.data?.data ?? [];
  }

  @override
  Future<List<ShopHistoryModel>> fetchShopHistoryById({required int shopId}) async {
    final response =
        await _networkManager.send<BaseResponseListModel<ShopHistoryModel>, BaseResponseListModel<ShopHistoryModel>>(
      NetworkEnums.shopHistoryById.key + shopId.toString(),
      parseModel: BaseResponseListModel(parseModel: ShopHistoryModel()),
      method: RequestType.GET,
    );

    return response.data?.data ?? [];
  }
  
  @override
  Future<BaseResult> resetShops(int sehirId) async{
      final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.resetShop.key + sehirId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.GET,
    );

    return response;
  }
}
