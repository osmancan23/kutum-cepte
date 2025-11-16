import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/theme/color/custom_color_scheme.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.width = 380,
    this.isPassword = false,
    this.onSaved,
    this.initialValue,
    this.prefixIcon,
    this.textEditingController,
    this.validator,
    this.labelText,
    this.borderRadius,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.prefixIconColor,
    this.contentPadding,
    this.isAuthScreen = true,
    this.maxLines = 1,
    this.fontSize = 14,
    this.textColor,
    this.isThereShadow = false,
    this.suffixIconSize = 20,
    this.inputFormatters,
    this.hintTextFontWeight = FontWeight.w500,
    this.noElevation = false,
    this.borderWidth = 1,
    this.suffixIcon,
    this.maxLength,
    this.onChange,
    this.onFocusFunction,
    this.textAlign,
    this.onTap,
    this.suffixWidget,
    this.readOnly,
    this.onSuffixIconTap,
    this.title,
  });
  final String? hintText;
  final bool isPassword;
  final double? width;
  final void Function(String? value)? onSaved;
  final void Function(String value)? onChange;
  final IconEnums? prefixIcon;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final TextInputType? textInputType;
  final Color? prefixIconColor;
  final Color? backgroundColor;
  final bool? isAuthScreen;
  final String? labelText;
  final double? fontSize;
  final Color? textColor;
  final bool? isThereShadow;
  final double? suffixIconSize;
  final String? initialValue;
  final FontWeight? hintTextFontWeight;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final bool noElevation;
  final double borderWidth;
  final IconEnums? suffixIcon;
  final int? maxLength;
  final VoidCallback? onFocusFunction;
  final VoidCallback? onTap;
  final TextAlign? textAlign;
  final Widget? suffixWidget;
  final bool? readOnly;
  final VoidCallback? onSuffixIconTap;
  final String? title;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _isShowPassword;
  final _focusNode = FocusNode();
  @override
  void initState() {
    _isShowPassword = widget.isPassword;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.onFocusFunction != null) {
        widget.onFocusFunction!();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                children: [
                  CustomText(
                    widget.title,
                    textStyle: context.general.textTheme.bodySmall?.copyWith(
                        color: context.general.colorScheme.onSurface),
                  ),
                  2.h.ph,
                ],
              ),
            )
          else
            const SizedBox(),
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius:
                  widget.borderRadius ?? context.border.lowBorderRadius,
            ),
            width: widget.width?.w,
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              cursorColor: context.general.colorScheme.primary,
              readOnly: widget.readOnly ?? false,
              focusNode: _focusNode,
              onChanged: (value) => widget.onChange?.call(value),
              onTap: () => widget.onTap,
              textAlign: widget.textAlign ?? TextAlign.start,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              controller: widget.textEditingController,
              initialValue: widget.initialValue,
              inputFormatters: widget.inputFormatters,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.textInputType,
              obscureText: _isShowPassword,
              obscuringCharacter: '*',
              style: context.general.textTheme.bodySmall?.copyWith(
                fontSize: widget.fontSize!.sp,
                fontWeight: widget.hintTextFontWeight,
              ),
              decoration: InputDecoration(
                errorMaxLines: 1,
                errorStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                ),
                suffixIcon: widget.suffixIcon != null
                    ? GestureDetector(
                        onTap: () {
                          widget.onSuffixIconTap?.call();
                          setState(() {
                            _isShowPassword = !_isShowPassword;
                          });
                        },
                        child: SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: SvgPicture.asset(
                            widget.suffixIcon!.svgPathIcon,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                prefixIcon: widget.prefixIcon != null
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: SvgPicture.asset(
                          widget.prefixIcon!.svgPathIcon,
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : null,
                //   suffix: widget.suffixWidget,
                hintText: widget.hintText,
                labelText: widget.labelText,
                prefixIconColor: widget.prefixIconColor,
                filled: true,
                fillColor: widget.backgroundColor,
                hintStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: CustomColorScheme.colorScheme.secondary,
                  fontSize: widget.fontSize!.sp,
                  fontWeight: widget.hintTextFontWeight,
                ),
                border: _buildOutlineInputBorder(),
                focusedErrorBorder: _buildOutlineInputBorder(
                  color: const Color(0xFFFA4F4F),
                ),
                enabledBorder: _buildOutlineInputBorder(),
                focusedBorder: _buildOutlineInputBorder(),
                errorBorder: _buildOutlineInputBorder(
                  color: const Color(0xFFFA4F4F),
                ),
                disabledBorder: _buildOutlineInputBorder(),
              ),
              validator: (value) => widget.validator?.call(value),
              onSaved: (value) => widget.onSaved?.call(value),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? context.border.lowBorderRadius,
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: widget.borderWidth,
      ),
    );
  }
}
