part of 'officer_tile_widget.dart';

Future<void> _deleteUserBottomSheetWidget(BuildContext context, {required int userId}) {
  return showBottomSheetWidget(
    context,
    body: Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.w,
            backgroundColor: context.general.colorScheme.primary,
            child: SvgImageWidget(
              icon: IconEnums.check,
              iconSize: 50.w,
              iconColor: Colors.white,
            ),
          ),
          10.h.ph,
          Center(
            child: SizedBox(
              width: 350.w,
              child: CustomText(
                'Kullanıcıyı silmek istediğine emin misin?',
                textStyle: context.general.textTheme.headlineSmall?.copyWith(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          16.h.ph,
          SizedBox(
            width: 250.w,
            child: CustomText(
              'Bu işlem geri alınamaz ve kullanıcı silinecektir.',
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
                  context.closePopup();
                  context.read<UserBloc>().add(DeleteUser(userId));
                },
                text: 'Sil',
                width: 180,
                radius: 16,
                buttonColor: context.general.colorScheme.error,
              ),
            ],
          ),
          16.h.ph,
        ],
      ),
    ),
  );
}
