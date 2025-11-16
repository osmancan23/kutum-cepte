import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';

Future<dynamic> popUpWidget(
  BuildContext context, {
  required Widget child,
  double borderRadius = 25,
  double height = 193,
  double width = 332,
  bool? isThereBorder = false,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            backgroundColor: context.general.colorScheme.onSecondary,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: context.border.highBorderRadius,
              side: BorderSide(
                color: Colors.transparent,
                width: isThereBorder! ? 1 : 0,
              ),
            ),
            content: SizedBox(
              height: height.h,
              width: width.w,
              child: Column(
                children: [
                  const _CloseWidget(),
                  Padding(
                    padding: context.padding.horizontalNormal,
                    child: child,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _CloseWidget extends StatelessWidget {
  const _CloseWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: context.padding.low,
          child: IconButton(
            onPressed: () => context.closePopup(),
            icon: Icon(
              Icons.close,
              color: context.general.colorScheme.secondary,
              size: 30.h,
            ),
          ),
        ),
      ],
    );
  }
}
