part of '../identity_card_view.dart';

class _IdentityCardWidget extends StatelessWidget {
  const _IdentityCardWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 400.w,
          height: 700.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Transform.scale(
              scale: 1.2,
              child: SvgPicture.asset(
                ImageEnums.identityCard.svgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 35.h,
          left: 50.w,

          child: Transform.rotate(
            angle: pi / 2,
            child: SizedBox(
              width: 254.w,
              height: 165.h,
              child: Image.asset(ImageEnums.logo.pngPath),
            ),
          ),
        ),
        Positioned(
          top: 150.h,
          left: 190.w,
          child: Transform.rotate(
            angle: pi / 2,
            child: const UserAvatarImageWidget(
              radius: 70,
            ),
          ),
        ),
        Positioned(
          top: 130.h,
          left: 80.w,
          child: Transform.rotate(
            angle: pi / 2,
            child: Padding(
              padding: EdgeInsets.only(left: 100.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  280.h.ph,
                  CustomText(
                    '${context.watch<AuthBloc>().state.user?.name} ${context.watch<AuthBloc>().state.user?.surname}',
                    textStyle: context.general.textTheme.titleLarge
                        ?.copyWith(fontSize: 30.sp),
                    maxCharacter: 16,
                  ),
                  10.h.ph,
                  SizedBox(
                    width: 200.w,
                    child: SvgPicture.asset(ImageEnums.cardActivity.svgPath),
                  ),
                  10.h.ph,
                  CustomText(
                    '+90 533 583 18 80',
                    textStyle:
                        context.general.textTheme.headlineLarge?.copyWith(),
                  ),
                  10.h.ph,
                  CustomText('info@hayalhanem.com',
                      textStyle:
                          context.general.textTheme.bodyMedium?.copyWith()),
                  10.h.ph,
                  CustomText(
                    'Esentepe, Dergiler Sokak No: 2/1 Şişli/İstanbul',
                    textStyle: context.general.textTheme.bodySmall?.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
