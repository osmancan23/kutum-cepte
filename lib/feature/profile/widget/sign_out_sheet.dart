part of '../profile_view.dart';

Future<dynamic> _signOutBottomSheet(BuildContext context) {
  return showBottomSheetWidget(
    context,
    body: Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: Column(
        children: [
          SvgImageWidget(
            icon: IconEnums.warning,
            iconSize: 50.w,
          ),
          10.h.ph,
          CustomText(
            'Çıkış yapacaksın, emin misin?',
            textStyle: context.general.textTheme.headlineMedium?.copyWith(),
          ),
          SizedBox(
            width: 250.w,
            child: CustomText(
              'İstediğin zaman tekrar giriş yapabilirsin.',
              textStyle: context.general.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400, color: context.general.colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
          ),
          16.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                onTap: () => context.closePopup(),
                text: 'Vazgeç',
                width: 180,
                radius: 16,
              ),
              16.h.ph,
              ButtonWidget(
                onTap: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                text: 'Çıkış Yap',
                buttonColor: context.general.colorScheme.error,
                width: 180,
                radius: 16,
              ),
            ],
          ),
          16.h.ph,
        ],
      ),
    ),
  );
}
