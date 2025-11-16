part of '../view/task_list_view.dart';

Future<dynamic> deleteTaskBottomSheet(
  BuildContext context,
  AdminTaskModel adminTaskModel,
  TaskType type,
  String? date,
) {
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
            'Görevi silmek istediğinize emin misiniz?',
            textStyle: context.general.textTheme.headlineMedium?.copyWith(),
          ),
          SizedBox(
            width: 250.w,
            child: CustomText(
              'Silinen görevler geri alınamaz.',
              textStyle: context.general.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.general.colorScheme.secondary,
              ),
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
                  type == TaskType.collector
                      ? context.read<TaskBloc>().add(
                            DeleteCollectorTask(
                              adminTaskModel: adminTaskModel,
                              date: date,
                            ),
                          )
                      : context.read<TaskBloc>().add(
                            DeleteDistributorTask(
                              taskId: adminTaskModel.taskId!,
                            ),
                          );
                  context.closePopup();
                },
                text: 'Sil',
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
