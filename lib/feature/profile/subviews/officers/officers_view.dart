import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';

import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/officers/viewModel/officers_view_model.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/officers/widget/officer_tile_widget.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

@RoutePage()
class OfficersView extends StatelessWidget {
  const OfficersView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: OfficersViewModel(),
      builder: (viewModel) {
        return ScaffoldWidget(
          appbarTitle: 'Kullanıcılar',
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.h.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Görevliler',
                      textStyle: context.general.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => context.router.push(AddOfficerAndUpdateRoute()),
                      child: CustomText(
                        'Kullanıcı Ekle',
                        textStyle: context.general.textTheme.bodyMedium?.copyWith(
                          color: context.general.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                20.h.ph,
                BlocConsumer<UserBloc, UserState>(
                  bloc: viewModel.userBloc,
                  listener: (context, state) {
                    if (state is UserCreateCompleted ||
                        state is UserUpdateCompleted ||
                        state is UserDeleteCompleted ||
                        state is UserCreateError ||
                        state is UserUpdateError ||
                        state is UserDeleteError) {
                      viewModel.userBloc.add(FetchAllUsers());
                    }
                  },
                  builder: (context, state) {
                    if (state is UserListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserListLoadCompleted) {
                      return state.users.isNotEmpty
                          ? Column(
                              children: [
                                ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.users.length,
                                  itemBuilder: (context, index) {
                                    final user = state.users[index];
                                    return OfficerTileWidget(
                                      userModel: user,
                                    );
                                  },
                                ),
                                const SizedBox(height: 40),
                              ],
                            )
                          : const Center(child: CustomText('Kullanıcı bulunamadı.'));
                    } else {
                      return const Center(child: CustomText('Kullanıcılar yüklenemedi.'));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
