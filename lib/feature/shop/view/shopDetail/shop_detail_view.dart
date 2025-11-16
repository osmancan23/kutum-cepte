import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/base/model/user_model.dart';
import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';

import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/popup/popup.dart';
import 'package:kutum_cepte_app/core/components/ratingBar/rating_bar.dart';
import 'package:kutum_cepte_app/core/components/scaffold/scaffold.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/box_status_enum.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/shop_status_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/profile/subviews/officers/widget/officer_tile_widget.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_comment_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_history_model.dart';
import 'package:kutum_cepte_app/feature/shop/model/shop_model.dart';
import 'package:kutum_cepte_app/feature/shop/service/shop_service.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/product/widget/imageBox/image_box_widget.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/list_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
part 'widget/shop_table_widget.dart';
part 'widget/shop_detail_images_widget.dart';
part 'widget/shop_info_box_widget.dart';
part 'widget/update_shop_popup_widget.dart';
part 'widget/shop_comment_widget.dart';
part 'widget/task_hand_over_popup_widget.dart';
part 'mixin/shop_detail_view_mixin.dart';
part 'widget/delete_shop_sheet_widget.dart';

@RoutePage()
class ShopDetailView extends StatefulWidget {
  const ShopDetailView({required this.shopId, this.taskId, super.key});
  final int shopId;
  final int? taskId;

  @override
  State<ShopDetailView> createState() => _ShopDetailViewState();
}

class _ShopDetailViewState extends State<ShopDetailView> with _ShopDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbarTitle: _appbarTitle ?? '',
      padding: EdgeInsets.zero,
      body: BlocBuilder<ShopBloc, ShopState>(
        bloc: _shopBloc,
        builder: (context, state) {
          if (state is ShopDetailLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        _ShopInfoBoxWidget(state.shop),
                        10.h.ph,
                        _ShopDetailImagesWidget(
                          state.shop.shopPhotosUrl,
                        ),
                        10.h.ph,
                        _CommentButtonWidget(_shopComments),
                        10.h.ph,
                        _DeleteShopWidget(shopId: widget.shopId),
                        10.h.ph,
                        if (widget.taskId != null)
                          _HandOffTaskWidget(widget.taskId!, state.shop.sehirDto!.id)
                        else
                          const SizedBox.shrink(),
                        10.h.ph,
                        GoogleMapWidget(
                          locations: [
                            MarkerModel(
                              id: state.shop.id.toString(),
                              latitude: state.shop.latitudeCordinate!.toDouble,
                              longitude: state.shop.longitudeCordinate!.toDouble,
                              title: state.shop.title,
                              markerType: MarkerType.handleMarkerType(state.shop.shopStatus),
                            ),
                          ],
                        ),
                        10.h.ph,
                        Row(
                          children: [
                            CustomText(
                              'Konum ile ilgili daha önceki veriler listelenmiştir',
                              textStyle: context.general.textTheme.bodyMedium
                                  ?.copyWith(color: context.general.colorScheme.onSurface, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  20.h.ph,
                  _ShopHistoryTableWidget(shopHistoryBloc: _shopHistoryBloc, shopId: widget.shopId),
                  20.h.ph,
                  if (widget.taskId != null)
                    Center(
                      child: ButtonWidget(
                        onTap: () async => _updateShopPopupWidget(context, shopId: widget.shopId,
                        sehirId: _shopModel!.sehirDto!.id!, ilceId:_shopModel!.ilceDto!.id!,
                        ),
                        text: 'Kutu Durum Güncelle',
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  40.h.ph,
                ],
              ),
            );
          } else if (state is ShopDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _DeleteShopWidget extends StatefulWidget {
  const _DeleteShopWidget({
    required this.shopId,
  });

  final int shopId;
  @override
  State<_DeleteShopWidget> createState() => _DeleteShopWidgetState();
}

class _DeleteShopWidgetState extends State<_DeleteShopWidget> {
  late ShopBloc _shopBloc;
  late StreamSubscription<ShopState> _shopSubscription;
  @override
  void initState() {
    _shopBloc = context.read<ShopBloc>();

    _shopSubscription = _shopBloc.stream.listen((state) {
      if (state is ShopDeleted) {
        if (mounted) {
          snackbarWidget(context, message: 'Dükkan başarıyla silindi');
          context.router.replaceAll([const MainRoute()]);
        } else {
          if (mounted) {
            snackbarWidget(context, message: 'Dükkan silinirken bir hata oluştu', type: SnackbarType.error);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _shopSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.read<AuthBloc>().state.user?.role == 'ROLE_USER'
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => _deleteShopBottomSheet(context, shopId: widget.shopId),
                child: CustomText(
                  'Dükkani Sil',
                  textStyle: context.general.textTheme.bodySmall?.copyWith(
                    color: context.general.colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
  }
}

class _ShopHistoryTableWidget extends StatelessWidget {
  const _ShopHistoryTableWidget({
    required ShopBloc shopHistoryBloc,
    required this.shopId,
  }) : _shopHistoryBloc = shopHistoryBloc;

  final ShopBloc _shopHistoryBloc;
  final int shopId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      bloc: _shopHistoryBloc,
      listener: (context, state) {
        if (state is ShopHistoryCreated || state is ShopHistoryCreateError) {
          context.closePopup();
          _shopHistoryBloc.add(FetchShopHistoryById(shopId));
        }
      },
      builder: (context, state) {
        if (state is ShopHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopHistoryLoaded) {
          return state.shopHistoryList.isNotEmpty
              ? _ShopTableWidget(state.shopHistoryList)
              : Column(
                  children: [
                    20.h.ph,
                    Center(
                      child: CustomText(
                        'Dükkan geçmişi bulunamadı',
                        textStyle: context.general.textTheme.bodyMedium
                            ?.copyWith(color: context.general.colorScheme.onSurface),
                      ),
                    ),
                  ],
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _HandOffTaskWidget extends StatelessWidget {
  const _HandOffTaskWidget(this.taskId, this.cityId);
  final int taskId;
  final int? cityId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => _taskHandOverPopupWidget(context, taskId: taskId, cityId: cityId!),
          child: CustomText(
            'Görevi Devret',
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: context.general.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
