import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/service/auth/auth_service.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';

final class DependcyInjector {
  DependcyInjector._init() {
    _authBloc = AuthBloc(locator<UserService>(), locator<AuthService>());
    _shopBloc = ShopBloc(locator<ShopService>());
    _taskBloc = TaskBloc(locator<TaskService>());
    _userBloc = UserBloc(locator<UserService>());
  }
  static DependcyInjector? _instance;

  static DependcyInjector get instance {
    _instance ??= DependcyInjector._init();
    return _instance!;
  }

  late final AuthBloc _authBloc;
  late final ShopBloc _shopBloc;
  late final TaskBloc _taskBloc;
  late final UserBloc _userBloc;

  // ignore: strict_raw_type
  List<BlocProvider<Bloc>> get globalBlocProviders => [
        BlocProvider<AuthBloc>(create: (context) => _authBloc),
        BlocProvider<ShopBloc>(create: (context) => _shopBloc),
        BlocProvider<TaskBloc>(create: (context) => _taskBloc),
        BlocProvider<UserBloc>(create: (context) => _userBloc),
      ];
}
