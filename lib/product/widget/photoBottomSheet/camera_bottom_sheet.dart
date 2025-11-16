import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

enum ImageChoiseType { camera, gallery }

/// MARK: Choise Photo Bottom Sheet Widget
Future<void> photoBottomSheetWidget(
  BuildContext context, {
  required void Function(File? image) onSelect,
  bool isStory = false,
}) {
  return showBottomSheetWidget(
    context,
    body: SizedBox(
      height: 150.h,
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          children: [
            20.h.ph,
            _buildItem(
              context,
              ImageChoiseType.gallery,
              () async => _choiseImage(context, ImageChoiseType.gallery).then((value) => onSelect.call(value)),
            ),
            20.h.ph,
            _buildItem(
              context,
              ImageChoiseType.camera,
              () async => _choiseImage(context, ImageChoiseType.camera).then((value) => onSelect.call(value)),
            ),
            4.h.ph,
          ],
        ),
      ),
    ),
  );
}

Padding _buildItem(BuildContext context, ImageChoiseType imageChoiseType, VoidCallback onTap) {
  return Padding(
    padding: context.padding.onlyLeftNormal,
    child: InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          SvgPicture.asset(
            (imageChoiseType == ImageChoiseType.gallery ? IconEnums.gallery : IconEnums.camera).svgPathIcon,
            //width: 7.w,
            fit: BoxFit.fill,
            color: context.general.colorScheme.onSurface,
          ),
          10.w.pw,
          CustomText(
            imageChoiseType == ImageChoiseType.gallery ? 'Galeriden Seç' : 'Fotoğraf Çek',
            textStyle: context.general.textTheme.bodyMedium
                ?.copyWith(color: context.general.colorScheme.onSurface, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Future<File?> _choiseImage(BuildContext context, ImageChoiseType imageChoiseType) async {
  context.closePopup();
  String? imagePath;
  bool? isSuccess = false;
  final imagePicker = ImagePicker();
  XFile? xfile;
  try {
    if (imageChoiseType == ImageChoiseType.camera) {
      xfile = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      xfile = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    imagePath = xfile?.path;
    isSuccess = true;
    return imagePath != null && isSuccess == true ? File(imagePath) : null;
  } catch (e) {
    return null;
  }
}
