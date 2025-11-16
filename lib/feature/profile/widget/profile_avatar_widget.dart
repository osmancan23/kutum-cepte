import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/product/widget/photoBottomSheet/camera_bottom_sheet.dart';

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget({
    required this.onSelect,
    super.key,
    this.photoUrl,
    this.isAuthUser = true,
  });
  final void Function(File? image) onSelect;
  final String? photoUrl;
  final bool isAuthUser;
  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 120.h,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => photoBottomSheetWidget(
              context,
              onSelect: (image) {
                setState(() {
                  this.image = image;
                });
                widget.onSelect(image);
              },
            ),
            child: image == null
                ? widget.isAuthUser
                    ? const UserAvatarImageWidget()
                    : CircleAvatar(
                        radius: 60.r,
                        backgroundImage: widget.photoUrl != null ? NetworkImage(widget.photoUrl!) : null,
                        child: widget.photoUrl == null
                            ? const Center(
                                child: SvgImageWidget(
                                  icon: IconEnums.profile,
                                  iconSize: 40,
                                ),
                              )
                            : null,
                      )
                : CircleAvatar(
                    radius: 60.r,
                    backgroundImage: FileImage(image!),
                  ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: SvgImageWidget(icon: IconEnums.editSquare, iconSize: 30),
          ),
        ],
      ),
    );
  }
}

/// MARK: Authicated User Avatar Image
class UserAvatarImageWidget extends StatelessWidget {
  const     UserAvatarImageWidget({
    super.key,
    this.radius = 60,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: context.general.colorScheme.surface,
      backgroundImage: context.watch<AuthBloc>().state.user?.photoUrl != null &&
              context.watch<AuthBloc>().state.user!.photoUrl != 'string'
          ? NetworkImage(context.read<AuthBloc>().state.user!.photoUrl!)
          : AssetImage(
              ImageEnums.pp.pngPath,
            ),
    );
  }
}
