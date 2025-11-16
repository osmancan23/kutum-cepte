import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/feature/profile/widget/profile_avatar_widget.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'widget/identity_card_widget.dart';

@RoutePage()
class IdentityCardView extends StatelessWidget {
  const IdentityCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _IdentityCardWidget(),
    );
  }
}
