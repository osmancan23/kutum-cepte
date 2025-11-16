part of '../collection_task_list_view.dart';

Future<dynamic> _completeTaskBottomSheet(BuildContext context) {
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
                'Kutu görevini tamamlamak istediğine emin misin?',
                textStyle: context.general.textTheme.headlineSmall?.copyWith(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          16.h.ph,
          SizedBox(
            width: 250.w,
            child: CustomText(
              'Bu işlem geri alınamaz ve kutu görevi tamamlanmış olarak işaretlenecektir.',
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
                buttonColor: context.general.colorScheme.error,
                text: 'Vazgeç',
                width: 180,
                radius: 16,
              ),
              16.h.ph,
              ButtonWidget(
                onTap: () {},
                text: 'Tamamla',
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
