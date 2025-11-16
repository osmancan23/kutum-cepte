part of '../profile_view.dart';

mixin _ProfileViewMixin on State<ProfileView> {
  late AuthBloc _authBloc;
  late StreamSubscription<AuthState> _authBlocSubscription;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();

    _authBlocSubscription = _authBloc.stream.listen((event) async {
      if (event.status == AuthStatus.unknown || event.status == AuthStatus.error) {
        if (mounted) {
          await context.router.replaceAll([const LoginRoute()]).then((value) {
            locator<VexanaManager>().clearHeader();
            locator<MainViewModel>().clearIndex();
          });
        }
      }
    });
    super.initState();
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authBlocSubscription.cancel();
    });
    super.dispose();
  }
}
