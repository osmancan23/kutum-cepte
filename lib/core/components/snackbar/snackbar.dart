import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';

enum SnackbarType {
  success,
  error;
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbarWidget(
  BuildContext context, {
  required String message,
  String? label,
  SnackbarType type = SnackbarType.success,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(
        message,
        maxLines: 5,
        textAlign: TextAlign.start,
        textStyle: context.general.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      action: SnackBarAction(
        label: label ?? '',
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: context.border.lowBorderRadius,
      ),
      backgroundColor: type == SnackbarType.success ? Colors.green : Colors.red,
    ),
  );
}
