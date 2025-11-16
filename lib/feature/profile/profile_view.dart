import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/main/viewModel/main_view_model.dart';
import 'package:kutum_cepte_app/feature/profile/widget/profile_avatar_widget.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'widget/menu_tile_widget.dart';
part 'widget/sign_out_sheet.dart';
part 'mixin/profile_view_mixin.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with _ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _UserInfoWidget(),
          10.h.ph,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _MenuTileEnum.values.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = _MenuTileEnum.values[index];
              return ((!context.isAdmin) && item.title == 'Kullanıcılar' ||
                          (!context.isAdmin) && item.title == 'Kutuları Sıfırla') ||
                      item.title == 'Dükkan Listesi'
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: context.padding.verticalLow,
                      child: _MenuTileWidget(
                        item: item,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  const _UserInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.router.push(const ProfileEditRoute()),
          child: const UserAvatarImageWidget(),
        ),
        10.h.ph,
        CustomText(
          '${context.watch<AuthBloc>().state.user?.name} ${context.watch<AuthBloc>().state.user?.surname}',
          textStyle: context.general.textTheme.headlineLarge,
        ),
        10.h.ph,
        CustomText(
          context.watch<AuthBloc>().state.user?.phone,
          textStyle: context.general.textTheme.bodySmall?.copyWith(),
        ),
      ],
    );
  }
}
