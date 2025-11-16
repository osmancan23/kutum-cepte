part of '../shop_detail_view.dart';

class _ShopInfoBoxWidget extends StatelessWidget {
  const _ShopInfoBoxWidget(this.shopModel);
  final ShopModel shopModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.getBoxShadow,
        borderRadius: context.border.normalBorderRadius,
      ),
      child: Padding(
        padding: context.padding.normal,
        child: Row(
          children: [
            ImageBoxWidget(
              imageUrl: shopModel.shopPhotosUrl?.getListItem(0),
              imageBoxType: ImageBoxType.readOnly,
            ),
            15.w.pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: CustomText(
                        shopModel.title,
                        textStyle: context.general.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        maxCharacter: 25,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.router.push(ShopEditRoute(shopModel: shopModel)),
                      child: SvgPicture.asset(IconEnums.edit2.svgPathIcon),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgImageWidget(
                      icon: IconEnums.location,
                      iconColor: context.general.colorScheme.primary,
                    ),
                    5.w.pw,
                    SizedBox(
                      width: 180.w,
                      child: CustomText(
                        '${shopModel.ilceDto?.title}/ ${shopModel.sehirDto?.title}',
                        textStyle: context.general.textTheme.bodySmall
                            ?.copyWith(color: context.general.colorScheme.onSurface, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
