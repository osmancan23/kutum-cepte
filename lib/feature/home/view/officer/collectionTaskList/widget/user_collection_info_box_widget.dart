part of '../collection_task_list_view.dart';

class _UserCollectionInfoBoxWidget extends StatelessWidget {
  const _UserCollectionInfoBoxWidget(this.taskResponseModel);
  final CollectorTaskResponseModel? taskResponseModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.getBoxShadow,
        borderRadius: context.border.normalBorderRadius,
      ),
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _contentTile(
              context,
              title: 'Sorumlu',
              value: '${taskResponseModel?.userName} / ${taskResponseModel?.userSurname}',
            ),
            _contentTile(
              context,
              title: 'İl',
              value: '${taskResponseModel?.sehir?.title}',
            ),
            _contentTile(context, title: 'Kutu Sayısı', value: '${taskResponseModel?.shopsCount ?? 0}'),
            /*  ButtonWidget(
              onTap: () => _completeTaskBottomSheet(context),
              width: 250,
              height: 48,
              fontSize: 14,
              text: 'Kutu Görevini Tamamla',
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _contentTile(BuildContext context, {required String title, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title,
              textStyle: context.general.textTheme.bodySmall?.copyWith(
                color: context.general.colorScheme.onSurface,
              ),
            ),
            CustomText(
              value,
              textStyle: context.general.textTheme.bodyMedium?.copyWith(),
            ),
          ],
        ),
      ],
    );
  }
}
