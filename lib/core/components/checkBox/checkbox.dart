import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

enum CheckBoxType { circle, square }

// ignore: must_be_immutable
class CheckboxWidget extends StatefulWidget {
  CheckboxWidget({
    super.key,
    this.title,
    this.isChecked = false,
    this.size,
    this.iconSize,
    this.selectedColor,
    this.textColor,
    this.borderColor,
    this.selectedIconColor,
    this.onClick,
    this.fontSize = 14,
    this.groupValue,
    this.isLeft = true,
  });
  bool? isChecked;
  final double? size;
  final double? iconSize;
  final Color? selectedColor;
  final Color? textColor;
  final Color? selectedIconColor;
  final Color? borderColor;
  final String? title;
  final double? fontSize;
  final void Function(String value)? onClick;
  final String? groupValue;

  ///MARK: - isLeft is used to determine the position of the checkbox
  final bool isLeft;

  @override
  // ignore: library_private_types_in_public_api
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.isLeft) _checkbox() else _title(context),
        10.w.pw,
        if (widget.isLeft) _title(context) else _checkbox(),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return CustomText(
      widget.title,
      textStyle: context.general.textTheme.bodyMedium?.copyWith(
        fontSize: widget.fontSize!.sp,
      ),
    );
  }

  Widget _checkbox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked!;
        });
        widget.onClick?.call(widget.title!);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.isChecked! ? context.general.colorScheme.primary : context.general.colorScheme.onSecondary,
          borderRadius: context.border.lowBorderRadius,
          border: Border.all(
            color: context.general.colorScheme.primary,
            width: 2.5,
          ),
        ),
        width: widget.size ?? 24.h,
        height: widget.size ?? 24.h,
      ),
    );
  }
}
