import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/cacheNetworkImage/cache_network_image_widget.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/product/widget/photoBottomSheet/camera_bottom_sheet.dart';

enum ImageBoxType { readOnly, clickOn }

class ImageBoxWidget extends StatefulWidget {
  const ImageBoxWidget({
    this.imageUrl,
    this.onSelect,
    this.width,
    this.height,
    this.borderRadius,
    super.key,
    this.imageBoxType = ImageBoxType.clickOn,
  });
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final String? imageUrl;
  final ImageBoxType? imageBoxType;
  final void Function(File? image)? onSelect;

  @override
  State<ImageBoxWidget> createState() => _ImageBoxWidgetState();
}

class _ImageBoxWidgetState extends State<ImageBoxWidget> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.imageBoxType == ImageBoxType.readOnly
          ? widget.imageUrl != null
              ? context.router.push(FullScreenImageRoute(url: widget.imageUrl!))
              : null
          : photoBottomSheetWidget(
              context,
              onSelect: (val) {
                setState(() {});
                image = val;
                widget.onSelect?.call(image);
                //  context.closePopup();
              },
            ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff1CC47D)),
          borderRadius: widget.borderRadius ?? context.border.normalBorderRadius,
        ),
        width: (widget.width ?? 120).w,
        height: (widget.height ?? 82).h,
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? context.border.normalBorderRadius,
          child: image == null && widget.imageUrl != null
              ? CacheNetworkImageWidget(imageUrl: widget.imageUrl!)
              : image == null
                  ? const Center(child: CustomText('Resim Seç'))
                  : Image.file(
                      image!,
                      fit: BoxFit.fill,
                    ),
        ),
      ),
    );
  }
}
