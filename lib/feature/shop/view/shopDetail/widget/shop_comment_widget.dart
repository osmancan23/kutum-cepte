part of '../shop_detail_view.dart';

class _CommentButtonWidget extends StatelessWidget {
  const _CommentButtonWidget(this._shopComments);
  final List<ShopCommentModel> _shopComments;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            popUpWidget(
              context,
              height: 550.h,
              child: SizedBox(
                height: 400.h,
                child: ListView.builder(
                  itemCount: _shopComments.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final shopCommentModel = _shopComments[index];
                    return Padding(
                      padding: context.padding.verticalLow,
                      child: _ShopCommentWidget(shopCommentModel),
                    );
                  },
                ),
              ),
            );
          },
          child: CustomText(
            'Yorumlar',
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class _ShopCommentWidget extends StatelessWidget {
  const _ShopCommentWidget(this._shopCommentModel);
  final ShopCommentModel _shopCommentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: context.border.lowBorderRadius,
        boxShadow: context.getBoxShadow,
      ),
      child: Padding(
        padding: context.padding.low,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              '${_shopCommentModel.userName} ${_shopCommentModel.userSurname}',
              textStyle: context.general.textTheme.bodyLarge?.copyWith(
                color: context.general.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              maxCharacter: 20,
            ),
            CustomText(
              _shopCommentModel.comment,
              textStyle: context.general.textTheme.bodySmall?.copyWith(),
              maxCharacter: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Puan: ${_shopCommentModel.rating ?? "-"} Yıldız',
                  textStyle: context.general.textTheme.bodySmall?.copyWith(),
                ),
                CustomText(
                  _shopCommentModel.commentDate?.toDayMonthYear,
                  textStyle: context.general.textTheme.bodySmall?.copyWith(
                    color: context.general.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
