import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/cacheNetworkImage/cache_network_image_widget.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';

import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'delete_user_bottom_sheet_widget.dart';

class OfficerTileWidget extends StatelessWidget {
  const OfficerTileWidget({required this.userModel, super.key, this.isHandOverWidget = false});
  final UserModel userModel;
  final bool isHandOverWidget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380.w,
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            _AvatarImageWidget(photoUrl: userModel.photoUrl),
            10.w.pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  '${userModel.name} ${userModel.surname}',
                  textStyle: context.general.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomText(
                  userModel.phone,
                  textStyle: context.general.textTheme.bodySmall?.copyWith(
                    color: context.general.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isHandOverWidget || context.isSuperAdmin == false)
              const SizedBox.shrink()
            else
              Row(
                children: [
                  InkWell(
                    onTap: () => context.router.push(AddOfficerAndUpdateRoute(userModel: userModel)),
                    child: SvgImageWidget(
                      icon: IconEnums.edit,
                      iconSize: 25.w,
                    ),
                  ),
                  10.w.pw,
                  InkWell(
                    onTap: () => _deleteUserBottomSheetWidget(context, userId: userModel.id!),
                    child: SvgImageWidget(
                      icon: IconEnums.delete,
                      iconSize: 25.w,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _AvatarImageWidget extends StatelessWidget {
  const _AvatarImageWidget({
    required this.photoUrl,
  });

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null) {
      return ClipRRect(
        borderRadius: context.border.highBorderRadius,
        child: CacheNetworkImageWidget(imageUrl: photoUrl!),
      );
    } else {
      return CircleAvatar(
        radius: 28.r,
        backgroundColor: context.general.colorScheme.onSurface,
        backgroundImage: AssetImage(
          ImageEnums.logo.pngPath,
        ),
      );
    }
  }
}
