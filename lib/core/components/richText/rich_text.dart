import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({required this.firstText, required this.secondText, super.key, this.seconTextColor, this.onTap});
  final String firstText;
  final String secondText;
  final Color? seconTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: GoogleFonts.inter(
          color: seconTextColor ?? Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' $secondText',
            style: GoogleFonts.inter(
              color: seconTextColor ?? Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                onTap?.call();
              },
          ),
        ],
      ),
    );
  }
}
