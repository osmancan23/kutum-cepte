import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';

import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@immutable
class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    required this.options,
    super.key,
    this.title,
    this.value,
    this.onChange,
    this.height = 56,
    this.width = 380,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius,
    this.hintText,
    this.icon,
    this.validator,
  });
  final String? value;
  final void Function(String?)? onChange;
  final List<String> options;
  final String? title;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderRadius;
  final String? hintText;
  final IconEnums? icon;
  final FormFieldValidator<String>? validator;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              children: [
                CustomText(
                  widget.title,
                  textStyle:
                      context.general.textTheme.bodySmall?.copyWith(color: context.general.colorScheme.onSurface),
                ),
                2.h.ph,
              ],
            ),
          )
        else
          const SizedBox(),
        Container(
          height: widget.height.h,
          width: widget.width.w,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? context.general.colorScheme.primaryContainer,
            borderRadius: context.border.lowBorderRadius,
          ),
          padding: context.padding.horizontalNormal,
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String?>(
              validator: widget.validator,
              dropdownColor: Colors.white,
              hint: CustomText(
                widget.hintText ?? '',
                textStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: context.general.colorScheme.secondary,
                ),
              ),
              decoration: InputDecoration(
                hoverColor: Colors.white,
                focusColor: Colors.white,
                fillColor: Colors.white,
                icon: widget.icon != null
                    ? SvgImageWidget(
                        icon: widget.icon!,
                        iconColor: context.general.colorScheme.secondary,
                      )
                    : null,
                border: InputBorder.none,
              ),
              value: widget.value,
              onChanged: (newValue) {
                widget.onChange!(newValue);
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 25,
                color: context.general.colorScheme.onPrimary,
              ),
              items: widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    value,
                    textStyle:
                        context.general.textTheme.bodySmall?.copyWith(color: context.general.colorScheme.onPrimary),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
