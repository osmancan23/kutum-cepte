part of '../view/task_list_view.dart';

class _TaskExpansionTileWidget extends StatelessWidget {
  const _TaskExpansionTileWidget({
    this.adminTaskDayModel,
  });
  final AdminTaskDayModel? adminTaskDayModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      decoration: BoxDecoration(
        borderRadius: context.border.lowBorderRadius,
        color: context.general.colorScheme.onSecondary,
        boxShadow: context.getBoxShadow,
      ),
      child: ListTileTheme(
        selectedTileColor: Colors.red,
        dense: false,
        selectedColor: Colors.red,
        child: ExpansionTile(
          initiallyExpanded: true,
          shape: const Border(),
          backgroundColor: context.general.colorScheme.onSecondary,
          textColor: context.general.colorScheme.onPrimary,
          collapsedTextColor: Colors.red,
          childrenPadding: context.padding.normal,
          expandedAlignment: Alignment.centerLeft,
          trailing: SvgPicture.asset(IconEnums.arrowDown.svgPathIcon),
          title: CustomText(
            adminTaskDayModel?.day,
            textStyle: context.general.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: context.general.colorScheme.primary),
          ),
          children: [
            _TaskListWidget(
              taskList: adminTaskDayModel?.collectors,
              type: TaskType.collector,
              date: adminTaskDayModel?.date,
            ),
            20.h.ph,
            _TaskListWidget(
              taskList: adminTaskDayModel?.distributors,
              type: TaskType.distributor,
            ),
          ],
        ),
      ),
    );
  }
}

final class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({required this.type, this.taskList, this.date});
  final List<AdminTaskModel>? taskList;
  final TaskType type;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              type.title,
              textStyle: context.general.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: context.general.colorScheme.onSurface),
            ),
          ],
        ),
        if (taskList?.isNotEmpty ?? false)
          ListView.builder(
            itemCount: taskList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final adminTaskModel = taskList?[index];
              return _TileWidget(adminTaskModel, type, date);
            },
          )
        else
          Center(
            child: CustomText(
              '${type.title} bulunamadı.',
              textStyle: context.general.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget(this.adminTaskModel, this.type, this.date);
  final AdminTaskModel? adminTaskModel;
  final TaskType type;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '${adminTaskModel?.userName} ${adminTaskModel?.userSurname}',
                maxCharacter: 14,
                textStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: context.general.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),

              CustomText(
                '${adminTaskModel?.sehir} / ${adminTaskModel?.ilce}',
                textStyle: context.general.textTheme.bodyMedium?.copyWith(),
              ),
              //SvgPicture.asset(IconEnums.edit.svgPathIcon),
              InkWell(
                onTap: () => deleteTaskBottomSheet(context, adminTaskModel!, type, date),
                child: SvgPicture.asset(IconEnums.delete.svgPathIcon),
              ),
            ],
          ),
          CustomText(
            '(Kutu Sayısı: ${adminTaskModel?.taskCount ?? 0})',
            textStyle: context.general.textTheme.bodySmall?.copyWith(
              color: context.general.colorScheme.secondary,
              fontSize: 8.sp,
            ),
          ),
        ],
      ),
    );
  }
}
