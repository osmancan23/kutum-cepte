part of '../collection_task_list_view.dart';

class _CollectionTaskTileWidget extends StatelessWidget {
  const _CollectionTaskTileWidget(this.taskShopModel);
  final TaskShopModel? taskShopModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router
          .push(ShopDetailRoute(shopId: taskShopModel!.shopByTaskCollectorDto!.id!, taskId: taskShopModel!.taskId)),
      child: Container(
        width: 380.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: context.border.normalBorderRadius,
          boxShadow: context.getBoxShadow,
        ),
        child: Padding(
          padding: context.padding.horizontalNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        taskShopModel?.shopByTaskCollectorDto?.title,
                        maxCharacter: 10,
                        textStyle: context.general.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      10.w.pw,
                      CustomText(
                        '(Dükkan No: ${taskShopModel?.shopByTaskCollectorDto?.shopNo})',
                        textStyle: context.general.textTheme.bodySmall?.copyWith(
                          color: context.general.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  if (taskShopModel?.isActive ?? true)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          'Detay',
                          textStyle: context.general.textTheme.bodyMedium
                              ?.copyWith(color: context.general.colorScheme.primary, fontWeight: FontWeight.bold),
                        ),
                        10.w.pw,
                        SvgPicture.asset(
                          IconEnums.arrowRight.svgPathIcon,
                          height: 20.w,
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: SvgImageWidget(
                        icon: IconEnums.check,
                        iconSize: 27.w,
                      ),
                    ),
                ],
              ),
              CustomText(
                '(${taskShopModel?.shopByTaskCollectorDto?.shopStatus})',
                textStyle: context.general.textTheme.bodySmall?.copyWith(
                  color: context.general.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
