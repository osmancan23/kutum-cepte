import 'package:kutum_cepte_app/core/base/model/base_error_model.dart';
import 'package:kutum_cepte_app/core/constants/app/app_constants.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:vexana/vexana.dart';

class VexanaManager extends NetworkManager<BaseModel> {
  VexanaManager()
      : super(
          options: BaseOptions(
            baseUrl: locator<ApplicationConstants>().baseUrl,
            followRedirects: true,
          ),
          errorModel: const BaseModel(),
          isEnableLogger: true,
          isEnableTest: true,
          
        );
}
