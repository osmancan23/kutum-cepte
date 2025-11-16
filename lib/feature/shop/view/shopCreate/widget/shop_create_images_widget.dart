part of '../shop_create_view.dart';

class _ShopCreateImagesWidget extends StatelessWidget {
  const _ShopCreateImagesWidget(this.viewModel);
  final ShopCreateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 395.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: context.general.colorScheme.primaryContainer,
            borderRadius: context.border.lowBorderRadius,
          ),
          child: Padding(
            padding: context.padding.horizontalNormal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Fotoğraf Ekle',
                  textStyle: context.general.textTheme.bodySmall,
                ),
                SvgPicture.asset(IconEnums.activity.svgPathIcon),
              ],
            ),
          ),
        ),
        20.h.ph,
        Row(
          children: [
            ImageBoxWidget(
              width: 184,
              height: 252,
              onSelect: (image) => viewModel.addShopImage(0, image),
            ),
            10.w.pw,
            Column(
              children: [
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  onSelect: (image) => viewModel.addShopImage(1, image),
                ),
                10.h.ph,
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  onSelect: (image) => viewModel.addShopImage(2, image),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
