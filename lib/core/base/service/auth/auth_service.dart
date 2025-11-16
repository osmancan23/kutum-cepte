import 'package:kutum_cepte_app/core/base/model/login_response_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/locale_storage/locale_storage_manager.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:vexana/vexana.dart';

abstract class IAuthService {
  IAuthService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  Future<LoginResponseModel?> login({required String phone, required String password});

  Future<void> updateToken(String? token);

  Future<void> updateTokenFromStorage();
}

class AuthService extends IAuthService {
  @override
  Future<LoginResponseModel?> login({required String phone, required String password}) async {
    final response = await _networkManager.send<LoginResponseModel, LoginResponseModel>(
      NetworkEnums.login.key,
      parseModel: const LoginResponseModel(),
      method: RequestType.POST,
      data: {
        'phone': phone,
        'password': password,
      },
    );

    return response.data;
  }

  @override
  Future<void> updateToken(String? token) async {
    try {
      if (token != null) {
        await LocalStorageManager.setString(LocalStorage.token.key, token);
        _networkManager.addBaseHeader(MapEntry('Authorization', 'Bearer  $token'));
      } else {
        if (await LocalStorageManager.containsKey(LocalStorage.token.key)) {
          await LocalStorageManager.remove(LocalStorage.token.key);
          _networkManager.removeHeader(LocalStorage.token.key);
        }
      }
    } catch (e) {
      print('HATA : $e');
    }
  }

  ///MARK: Update token from storage when app started
  @override
  Future<void> updateTokenFromStorage() async {
    if (await LocalStorageManager.containsKey(LocalStorage.token.key)) {
      final token = await LocalStorageManager.getString(LocalStorage.token.key);
      if (token != null) {
        _networkManager.addBaseHeader(MapEntry('Authorization', 'Bearer  $token'));
      }
    }
  }
}
