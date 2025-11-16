part of '../../main/view/main_view.dart';

class _IdentityCardAppbarWidget extends StatelessWidget {
  const _IdentityCardAppbarWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150.h,
      child: Padding(
        padding: context.padding.normal.copyWith(top: 60.h),
        child: Row(
          children: [
            CustomText(
              '${context.watch<AuthBloc>().state.user?.name} ${context.watch<AuthBloc>().state.user?.surname}',
              textStyle: context.general.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const SvgImageWidget(icon: IconEnums.notification, iconSize: 25),
            20.w.pw,
            const SvgImageWidget(icon: IconEnums.bookmark, iconSize: 25),
            10.w.pw,
          ],
        ),
      ),
    );
  }
}
