import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

Future<dynamic> showBottomSheetWidget(BuildContext context, {Widget? body}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.general.colorScheme.onSecondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.general.colorScheme.onSecondary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  2.h.ph,
                  _buildDivider(context),
                  2.h.ph,
                  body ?? 0.ph,
                  //7.h.ph,
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Container _buildDivider(BuildContext context) {
  return Container(
    width: 40,
    height: 5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: context.general.colorScheme.secondary,
    ),
  );
}
