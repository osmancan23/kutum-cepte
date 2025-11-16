part of '../../main/view/main_view.dart';

class _HomeViewAppbarWidget extends StatelessWidget {
  final TabbarItemEnum? tab;
  const _HomeViewAppbarWidget({this.tab});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: Padding(
        padding: context.padding.normal.copyWith(top: 60.h),
        child: Column(
          children: [
            Row(
              children: [
                const UserAvatarImageWidget(
                  radius: 30,
                ),
                15.w.pw,
                CustomText(
                  '${context.watch<AuthBloc>().state.user?.name} ${context.watch<AuthBloc>().state.user?.surname}',
                  textStyle: context.general.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxCharacter: 20,
                ),
                const Spacer(),
                const SvgImageWidget(icon: IconEnums.notification, iconSize: 25),
                20.w.pw,
                const SvgImageWidget(icon: IconEnums.bookmark, iconSize: 25),
                10.w.pw,
              ],
            ),
            20.h.ph,
            TabbarWidget(
              firstItem: tab,
              onChange: (tab) {
                locator<HomeViewModel>().selectedTab = tab;
              },
              type: context.isAdmin ? TabbarType.admin : TabbarType.user,
            ),
          ],
        ),
      ),
    );
  }
}
