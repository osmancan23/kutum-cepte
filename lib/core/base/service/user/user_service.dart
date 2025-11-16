import 'package:kutum_cepte_app/core/base/model/base_error_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_list_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_model.dart';
import 'package:kutum_cepte_app/core/base/model/login_response_model.dart';
import 'package:kutum_cepte_app/core/base/model/update_and_create_user_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/locale_storage/locale_storage_manager.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:kutum_cepte_app/utils/typedefs/typedefs.dart';
import 'package:vexana/vexana.dart';

abstract class IUserService {
  IUserService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  Future<UserModel?> fetchCurrentUser();

  Future<List<UserModel>> fetchAllUsers();
  Future<List<UserModel>> fetchUsersByCityId(int cityId);
  Future<UserModel?> fetchUserById(int id);

  Future<BaseResult> createUser(UpdateAndCreateUserModel user);
  Future<BaseResult> deleteUserById({required int id});
  Future<BaseResult> updateUserForAdmin({required int id, required UpdateAndCreateUserModel user});
  Future<BaseResult> updateUser({required UpdateAndCreateUserModel user, required int id});

  Future<BaseResult> changePassword({required int userId, required String oldPassword, required String newPassword});

  Future<String?> fetchKvkText();
}

class UserService extends IUserService {
  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final response = await _networkManager.send<BaseResponseListModel<UserModel>, BaseResponseListModel<UserModel>>(
      NetworkEnums.userAll.key,
      parseModel: const BaseResponseListModel(parseModel: UserModel()),
      method: RequestType.GET,
    );

    return response.data?.data ?? [];
  }

  @override
  Future<UserModel?> fetchUserById(int id) async {
    final response = await _networkManager.send<BaseResponseModel<UserModel>, BaseResponseModel<UserModel>>(
      NetworkEnums.userById.key + id.toString(),
      parseModel: const BaseResponseModel(parseModel: UserModel()),
      method: RequestType.GET,
    );

    return response.data?.data;
  }

  @override
  Future<BaseResult> deleteUserById({required int id}) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.deleteUser.key + id.toString(),
      parseModel: const BaseModel(),
      method: RequestType.DELETE,
    );

    return response;
  }

  @override
  Future<BaseResult> updateUserForAdmin({
    required int id,
    required UpdateAndCreateUserModel user,
  }) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.updateUserForAdmin.key + id.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: user.toJson(),
    );

    return response;
  }

  @override
  Future<BaseResult> updateUser({required UpdateAndCreateUserModel user, required int id}) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.updateUser.key + id.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: user.toJson(),
      
    );

    return response;
  }

  @override
  Future<BaseResult> createUser(UpdateAndCreateUserModel user) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.createUser.key,
      parseModel: const BaseModel(),
      method: RequestType.POST,
      data: user.toJson(),
    );

    return response;
  }

  @override
  Future<BaseResult> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.changePassword.key + userId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );

    return response;
  }

  @override
  Future<UserModel?> fetchCurrentUser() async {
    final token = await LocalStorageManager.getString(LocalStorage.token.key);
    final response = await _networkManager.send<BaseResponseModel<UserModel>, BaseResponseModel<UserModel>>(
      '${NetworkEnums.currentUser.key}$token',
      parseModel: const BaseResponseModel(parseModel: UserModel()),
      method: RequestType.GET,
    );

    return response.data?.data;
  }

  @override
  Future<String?> fetchKvkText() async {
    final response = await _networkManager.send<LoginResponseModel, LoginResponseModel>(
      NetworkEnums.kvkk.key,
      parseModel: const LoginResponseModel(),
      method: RequestType.GET,
    );

    return response.data?.data;
  }

  @override
  Future<List<UserModel>> fetchUsersByCityId(int cityId) async {
    final response = await _networkManager.send<BaseResponseListModel<UserModel>, BaseResponseListModel<UserModel>>(
      NetworkEnums.usersByCity.key,
      queryParameters: {'sehirId': cityId},
      parseModel: const BaseResponseListModel(parseModel: UserModel()),
      method: RequestType.GET,
    );

    return response.data?.data ?? [];
  }
}
