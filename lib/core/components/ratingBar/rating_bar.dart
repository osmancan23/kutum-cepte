import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/constants/app/color_constants.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    this.itemSize,
    this.itemPaddingForChanging,
    this.rating,
    this.paddingForReadOnly,
    this.onChange,
  });
  final double? itemSize;
  final EdgeInsetsGeometry? itemPaddingForChanging;
  final EdgeInsets? paddingForReadOnly;

  final double? rating;
  final void Function(double count)? onChange;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      minRating: 1,
      updateOnDrag: true,
      itemSize: (itemSize ?? 30).w,
      itemPadding: itemPaddingForChanging ?? context.padding.horizontalLow.copyWith(right: 3.w, left: 3.w),
      unratedColor: locator<ColorConstants>().lightGray,
      glow: false,
      itemBuilder: (context, _) => SvgImageWidget(
        icon: IconEnums.rating,
        iconColor: context.general.colorScheme.primary,
      ),
      onRatingUpdate: (rating) {
        onChange?.call(rating);
      },
    );
  }
}
