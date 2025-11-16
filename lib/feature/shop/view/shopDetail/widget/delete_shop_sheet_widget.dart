part of '../shop_detail_view.dart';

Future<dynamic> _deleteShopBottomSheet(BuildContext context,{required int shopId}) {
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
            'Dükkanı sileceksin, emin misin?',
            textStyle: context.general.textTheme.headlineMedium?.copyWith(),
          ),
          SizedBox(
            width: 250.w,
            child: CustomText(
              'Dükkanı sildiğinde geri alamazsın.',
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
                  context.read<ShopBloc>().add(DeleteShop(shopId));
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
