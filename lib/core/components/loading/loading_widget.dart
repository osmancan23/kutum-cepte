import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({required this.isLoading, super.key});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        maintainAnimation: true,
        maintainSize: true,
        maintainState: true,
        visible: isLoading,
        child: Container(
          height: context.sized.dynamicHeight(1),
          width: context.sized.dynamicWidth(1),
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'loading2'.toLottieJson,
                repeat: true,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
