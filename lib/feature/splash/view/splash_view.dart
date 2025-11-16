import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';

import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:lottie/lottie.dart';
part '../mixin/splash_view_mixin.dart';

@RoutePage()
final class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with _SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.general.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            200.h.ph,
            SizedBox(
              width: 255.w,
              height: 201.h,
              child: Image.asset(ImageEnums.logo.pngPath),
            ),
            150.h.ph, // Logonun altına boşluk eklemek için
            Lottie.asset(
              _lottiePath,
              width: 150.w,
              height: 150.h,
              fit: BoxFit.fill,
            ),

            100.h.ph, // Alt kısımda ekstra boşluk
          ],
        ),
      ),
    );
  }
}
