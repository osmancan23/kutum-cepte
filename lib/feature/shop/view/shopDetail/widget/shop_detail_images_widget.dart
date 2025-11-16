part of '../shop_detail_view.dart';

class _ShopDetailImagesWidget extends StatelessWidget {
  const _ShopDetailImagesWidget(this.shopInitialImages);
  final List<String?>? shopInitialImages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Fotoğraflar',
              textStyle: context.general.textTheme.headlineSmall,
            ),
            CustomText(
              'Hepsini Gör',
              textStyle: context.general.textTheme.bodyMedium?.copyWith(
                color: context.general.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        20.h.ph,
        Row(
          children: [
            ImageBoxWidget(
              width: 184,
              height: 252,
              imageUrl: _handleImageUrl(0),
              imageBoxType: ImageBoxType.readOnly,
            ),
            10.w.pw,
            Column(
              children: [
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  imageUrl: _handleImageUrl(1),
                  imageBoxType: ImageBoxType.readOnly,
                ),
                10.h.ph,
                ImageBoxWidget(
                  width: 184,
                  height: 120,
                  imageUrl: _handleImageUrl(2),
                  imageBoxType: ImageBoxType.readOnly,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String? _handleImageUrl(int id) => (shopInitialImages?.length ?? 0) > id ? shopInitialImages?.elementAt(id) : null;
}
