import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kutum_cepte_app/core/components/noNetwork/no_network.dart';
import 'package:kutum_cepte_app/core/constants/enums/global_enums.dart';
import 'package:kutum_cepte_app/core/dependcy_injector.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/core/init/theme/app_theme.dart';
import 'package:kutum_cepte_app/product/init/app_init.dart';
import 'package:kutum_cepte_app/utils/mixin/global_mixin.dart';

Future<void> main() async {
  await ApplicationInit.instance?.appInit();
  runApp(
    MultiBlocProvider(
      providers: DependcyInjector.instance.globalBlocProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with GlobalMixin {
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');

    return ScreenUtilInit(
      designSize: Size(SizeEnums.designSize.width, SizeEnums.designSize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (conttext, child) => GestureDetector(
        onTap: dismissKeyboard,
        child: MaterialApp.router(
          locale: const Locale('tr', 'TR'),
          supportedLocales: const [
            Locale('tr', 'TR'), // Türkçe
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.instance?.theme,
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(includePrefixMatches: true),
          builder: (context, child) {
            return MainBuild(child: child);
          },
        ),
      ),
    );
  }
}

class MainBuild extends StatelessWidget {
  const MainBuild({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child ?? const SizedBox.shrink()),
        const NoNetworkWidget(),
      ],
    );
  }
}
