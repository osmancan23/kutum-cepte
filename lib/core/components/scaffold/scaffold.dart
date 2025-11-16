import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutum_cepte_app/core/components/appbar/appbar.dart';

enum AuroraTypeEnum { single, double, triple }

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    required this.body,
    super.key,
    this.bottomNavigationBar,
    this.appbarTitle,
    this.onTapAppBarLeading,
    this.trailingWidget,
    this.padding,
  });
  final Widget body;
  final Widget? bottomNavigationBar;
  final String? appbarTitle;
  final VoidCallback? onTapAppBarLeading;
  final Widget? trailingWidget;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: appbarTitle,
        leadingPress: onTapAppBarLeading,
        trailingWidget: trailingWidget,
      ),
      body: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
