import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/firebase_options.dart';

final class ApplicationInit {
  ApplicationInit._init();
  static ApplicationInit? _instance;

  static ApplicationInit? get instance {
    // ignore: join_return_with_assignment
    _instance ??= ApplicationInit._init();
    return _instance;
  }

  late List<CameraDescription> cameras;

  Future<void> appInit() async {
    WidgetsFlutterBinding.ensureInitialized();

    HttpOverrides.global = MyHttpOverrides();

    cameras = await availableCameras();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


    setupLocator();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
