part of '../shop_edit_view.dart';

class _ShopEditImagesWidget extends StatelessWidget {
  const _ShopEditImagesWidget({required this.viewModel, this.shopInitialImages});
  final List<String?>? shopInitialImages;
  final ShopEditViewModel viewModel;
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
        10.h.ph,
        Row(
          children: [
            ImageBoxWidget(
              width: 184,
              height: 252,
              imageUrl: shopInitialImages?.getListItem(0),
              onSelect: (image) => viewModel.addShopImage(0, image),
            ),
            10.w.pw,
            Column(
              children: [
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  imageUrl: shopInitialImages?.getListItem(1),
                  onSelect: (image) => viewModel.addShopImage(1, image),
                ),
                10.h.ph,
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  imageUrl: shopInitialImages?.getListItem(2),
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
