import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.title,
    this.leadingPress,
    this.trailingWidget,
  });
  final String? title;
  final VoidCallback? leadingPress;
  final Widget? trailingWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: context.router.canPop()
          ? GestureDetector(
              onTap: () {
                leadingPress != null ? leadingPress?.call() : context.router.back();
              },
              child: SvgPicture.asset(
                IconEnums.arrowLeft.svgPathIcon,
                fit: BoxFit.scaleDown,
              ),
            )
          : null,
      title: CustomText(
        title,
        textStyle: context.general.textTheme.headlineLarge?.copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [trailingWidget ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 64.h);
}
