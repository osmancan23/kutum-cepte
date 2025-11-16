part of '../shop_detail_view.dart';

Future<void> _updateShopPopupWidget(
  BuildContext context, {
  required int shopId,
  required int sehirId,
  required int ilceId,
}) async {
  String? shopStatus;
  String? boxStatus;
  String? comment;
  int? rating;
  var isCollected = false;
  var isAgainBox = false;
  return popUpWidget(
    context,
    width: 340,
    height: 620,
    child: StatefulBuilder(
      builder: (context, setState) => SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            CustomText(
              'Güncelleme Yap',
              textStyle: context.general.textTheme.headlineLarge?.copyWith(color: context.general.colorScheme.primary),
            ),
            20.h.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Dükkan Durum Güncelleme',
                  textStyle: context.general.textTheme.bodyLarge?.copyWith(),
                ),
                10.h.ph,
                DropdownButtonWidget(
                  width: 260,
                  options: ShopStatusEnum.values.map((e) => e.title).toList(),
                  onChange: (p0) {
                    shopStatus = ShopStatusEnum.values.firstWhere((element) => element.title == p0).value;
                    isCollected = shopStatus == ShopStatusEnum.collected.value;
                    setState(() {});
                  },
                ),
                10.h.ph,
                if (shopStatus == ShopStatusEnum.lost.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Tekrar kutu bırakıldı mı ?',
                        textStyle: context.general.textTheme.bodyLarge?.copyWith(),
                      ),
                      10.h.ph,
                      DropdownButtonWidget(
                        width: 260,
                        options: const ['Evet', 'Hayır'],
                        onChange: (p0) {
                          isAgainBox = p0 == 'Evet';
                        },
                      ),
                    ],
                  )
                else
                  const SizedBox.shrink(),
                if (isCollected)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Kutu Doluluk Orani',
                        textStyle: context.general.textTheme.bodyLarge?.copyWith(),
                      ),
                      10.h.ph,
                      DropdownButtonWidget(
                        width: 260,
                        options: BoxStatusEnum.values.map((e) => e.title).toList(),
                        onChange: (p0) =>
                            boxStatus = BoxStatusEnum.values.firstWhere((element) => element.title == p0).value,
                      ),
                    ],
                  )
                else
                  const SizedBox.shrink(),
                20.h.ph,
                SizedBox(
                  height: 150.h,
                  child: TextFormFieldWidget(
                    width: 260,
                    hintText: 'Görüş ve Öneri ve Yorumlar',
                    maxLines: 4,
                    onChange: (value) => comment = value,
                  ),
                ),
              ],
            ),
            Center(
              child: RatingBarWidget(
                onChange: (count) => rating = count.toInt(),
              ),
            ),
            20.h.ph,
            ButtonWidget(
              onTap: () {
                if (shopStatus != null && rating != null) {
                  if (shopStatus == ShopStatusEnum.lost.value) {
                    if (isAgainBox) {
                      shopStatus = ShopStatusEnum.collected.value;
                      boxStatus = BoxStatusEnum.empty.value;
                    } else {
                      shopStatus = ShopStatusEnum.givingBack.value;
                    }
                  }

                  context.read<ShopBloc>().add(
                        CreateShopHistory(
                          ShopHistoryModel(
                            shopId: shopId,
                            shopStatus: shopStatus,
                            boxStatus: boxStatus ?? 'BOS',
                            description: comment ?? '-',
                            point: rating,
                            date: DateTime.now().formattedDate,
                            userId: context.read<AuthBloc>().state.user?.id.toString(),
                            isAgainBox: isAgainBox,
                          ),
                          sehirId,
                          ilceId,
                        ),
                      );

                  context.closePopup();
                  context.router.replace(const MainRoute());
                }
              },
              text: 'Güncelle',
            ),
            // const RatingBarWidget(),
          ],
        ),
      ),
    ),
  );
}
