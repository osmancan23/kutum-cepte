// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [AddOfficerAndUpdateView]
class AddOfficerAndUpdateRoute
    extends PageRouteInfo<AddOfficerAndUpdateRouteArgs> {
  AddOfficerAndUpdateRoute({
    Key? key,
    UserModel? userModel,
    List<PageRouteInfo>? children,
  }) : super(
          AddOfficerAndUpdateRoute.name,
          args: AddOfficerAndUpdateRouteArgs(
            key: key,
            userModel: userModel,
          ),
          initialChildren: children,
        );

  static const String name = 'AddOfficerAndUpdateRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddOfficerAndUpdateRouteArgs>(
          orElse: () => const AddOfficerAndUpdateRouteArgs());
      return AddOfficerAndUpdateView(
        key: args.key,
        userModel: args.userModel,
      );
    },
  );
}

class AddOfficerAndUpdateRouteArgs {
  const AddOfficerAndUpdateRouteArgs({
    this.key,
    this.userModel,
  });

  final Key? key;

  final UserModel? userModel;

  @override
  String toString() {
    return 'AddOfficerAndUpdateRouteArgs{key: $key, userModel: $userModel}';
  }
}

/// generated route for
/// [ChangePasswordView]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangePasswordView();
    },
  );
}

/// generated route for
/// [FullScreenImageView]
class FullScreenImageRoute extends PageRouteInfo<FullScreenImageRouteArgs> {
  FullScreenImageRoute({
    required String url,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          FullScreenImageRoute.name,
          args: FullScreenImageRouteArgs(
            url: url,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FullScreenImageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FullScreenImageRouteArgs>();
      return FullScreenImageView(
        url: args.url,
        key: args.key,
      );
    },
  );
}

class FullScreenImageRouteArgs {
  const FullScreenImageRouteArgs({
    required this.url,
    this.key,
  });

  final String url;

  final Key? key;

  @override
  String toString() {
    return 'FullScreenImageRouteArgs{url: $url, key: $key}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [IdentityCardView]
class IdentityCardRoute extends PageRouteInfo<void> {
  const IdentityCardRoute({List<PageRouteInfo>? children})
      : super(
          IdentityCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'IdentityCardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IdentityCardView();
    },
  );
}

/// generated route for
/// [KvkTextView]
class KvkTextRoute extends PageRouteInfo<void> {
  const KvkTextRoute({List<PageRouteInfo>? children})
      : super(
          KvkTextRoute.name,
          initialChildren: children,
        );

  static const String name = 'KvkTextRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const KvkTextView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [MainView]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainView();
    },
  );
}

/// generated route for
/// [OfficersView]
class OfficersRoute extends PageRouteInfo<void> {
  const OfficersRoute({List<PageRouteInfo>? children})
      : super(
          OfficersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OfficersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OfficersView();
    },
  );
}

/// generated route for
/// [ProfileEditView]
class ProfileEditRoute extends PageRouteInfo<void> {
  const ProfileEditRoute({List<PageRouteInfo>? children})
      : super(
          ProfileEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileEditView();
    },
  );
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileView();
    },
  );
}

/// generated route for
/// [ReportsView]
class ReportsRoute extends PageRouteInfo<void> {
  const ReportsRoute({List<PageRouteInfo>? children})
      : super(
          ReportsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportsView();
    },
  );
}

/// generated route for
/// [ResetBoxesView]
class ResetBoxesRoute extends PageRouteInfo<void> {
  const ResetBoxesRoute({List<PageRouteInfo>? children})
      : super(
          ResetBoxesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetBoxesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetBoxesView();
    },
  );
}

/// generated route for
/// [ShopCreateView]
class ShopCreateRoute extends PageRouteInfo<void> {
  const ShopCreateRoute({List<PageRouteInfo>? children})
      : super(
          ShopCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopCreateRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShopCreateView();
    },
  );
}

/// generated route for
/// [ShopDetailView]
class ShopDetailRoute extends PageRouteInfo<ShopDetailRouteArgs> {
  ShopDetailRoute({
    required int shopId,
    int? taskId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ShopDetailRoute.name,
          args: ShopDetailRouteArgs(
            shopId: shopId,
            taskId: taskId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopDetailRouteArgs>();
      return ShopDetailView(
        shopId: args.shopId,
        taskId: args.taskId,
        key: args.key,
      );
    },
  );
}

class ShopDetailRouteArgs {
  const ShopDetailRouteArgs({
    required this.shopId,
    this.taskId,
    this.key,
  });

  final int shopId;

  final int? taskId;

  final Key? key;

  @override
  String toString() {
    return 'ShopDetailRouteArgs{shopId: $shopId, taskId: $taskId, key: $key}';
  }
}

/// generated route for
/// [ShopEditView]
class ShopEditRoute extends PageRouteInfo<ShopEditRouteArgs> {
  ShopEditRoute({
    required ShopModel shopModel,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ShopEditRoute.name,
          args: ShopEditRouteArgs(
            shopModel: shopModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopEditRouteArgs>();
      return ShopEditView(
        shopModel: args.shopModel,
        key: args.key,
      );
    },
  );
}

class ShopEditRouteArgs {
  const ShopEditRouteArgs({
    required this.shopModel,
    this.key,
  });

  final ShopModel shopModel;

  final Key? key;

  @override
  String toString() {
    return 'ShopEditRouteArgs{shopModel: $shopModel, key: $key}';
  }
}

/// generated route for
/// [ShopListView]
class ShopListRoute extends PageRouteInfo<void> {
  const ShopListRoute({List<PageRouteInfo>? children})
      : super(
          ShopListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShopListView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}
