part of '../view/splash_view.dart';

mixin _SplashViewMixin on State<SplashView> {
  String get _lottiePath => 'assets/animations/lottie_loading.json';
  late AuthBloc _authBloc;
  late StreamSubscription<AuthState> _authBlocSubscription;
  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
    _authBloc.add(AppStarted());

    _authBlocSubscription = _authBloc.stream.listen((event) async {
      if (mounted) {
        if (event.status == AuthStatus.authenticated) {
          await Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                context.router.replace(const HomeRoute());
              });
            }
          });
        } else {
          context.router.replace(const LoginRoute());
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authBlocSubscription.cancel();
    });
    super.dispose();
  }
}
