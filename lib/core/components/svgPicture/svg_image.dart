import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';

class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget({required this.icon, super.key, this.iconColor, this.iconSize});
  final IconEnums icon;
  final Color? iconColor;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.svgPathIcon,
      height: iconSize ?? 17.w,
      colorFilter: iconColor != null ? ColorFilter.mode(iconColor ?? Colors.black, BlendMode.srcIn) : null,
    );
  }
}
