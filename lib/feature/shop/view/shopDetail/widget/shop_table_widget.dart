part of '../shop_detail_view.dart';

class _ShopTableWidget extends StatelessWidget {
  const _ShopTableWidget(this.shopHistoryList);

  final List<ShopHistoryModel> shopHistoryList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _tableTitleWidget(context, title: 'Tarih'),
            _tableTitleWidget(context, title: 'İade'),
            _tableTitleWidget(context, title: 'Kayıp'),
            _tableTitleWidget(context, title: 'Kapalı'),
            _tableTitleWidget(context, title: 'Toplandı'),
          ],
        ),
        10.h.ph,
        ListView.builder(
          itemCount: shopHistoryList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final shopHistoryModel = shopHistoryList[index];
            return _TableRowWidget(shopHistoryModel);
          },
        ),
      ],
    );
  }

  Widget _tableTitleWidget(BuildContext context, {String? title}) {
    return SizedBox(
      width: 70.w,
      height: 56.h,
      child: Center(
        child: CustomText(
          title,
          textStyle: context.general.textTheme.bodySmall?.copyWith(
            color: context.general.colorScheme.onSurface,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}

class _TableRowWidget extends StatelessWidget {
  const _TableRowWidget(this.shopHistoryModel);
  final ShopHistoryModel shopHistoryModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.verticalLow.copyWith(top: 3.h, bottom: 3.h),
      child: Container(
        height: 80.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.getBoxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dateLabelWidget(context),
            _valueLabelWidget(context, status: ShopStatusEnum.givingBack),
            _valueLabelWidget(context, status: ShopStatusEnum.lost),
            _valueLabelWidget(context, status: ShopStatusEnum.closed),
            _valueLabelWidget(context, status: ShopStatusEnum.collected),
          ],
        ),
      ),
    );
  }

  SizedBox _valueLabelWidget(BuildContext context, {required ShopStatusEnum status}) {
    return SizedBox(
      width: 68.w,
      child: Center(
        child: SvgImageWidget(
          icon: status.value == shopHistoryModel.shopStatus ? IconEnums.check : IconEnums.minus,
          iconSize: 25.w,
        ),
      ),
    );
  }

  SizedBox _dateLabelWidget(BuildContext context) {
    return SizedBox(
      width: 68.w,
      child: Center(
        child: CustomText(
          shopHistoryModel.date?.toDayMonthYear,
          textStyle: context.general.textTheme.bodySmall,
          maxLines: 1,
          maxFontSize: 12,
          minFontSize: 8,
        ),
      ),
    );
  }
}
