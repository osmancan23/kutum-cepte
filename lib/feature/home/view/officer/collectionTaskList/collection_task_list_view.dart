import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/model/collector_task_response_model.dart';
import 'package:kutum_cepte_app/feature/home/model/task_shop_model.dart';
import 'package:kutum_cepte_app/feature/home/view/widget/complete_task_widget.dart';
import 'package:kutum_cepte_app/feature/shop/bloc/shop_bloc.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
part 'widget/collection_task_tile_widget.dart';
part 'widget/user_collection_info_box_widget.dart';
part 'mixin/collection_task_list_view_mixin.dart';
part 'widget/complete_task_bottom_sheet.dart';
part 'widget/searchable_shop_list_widget.dart';

final class CollectionTaskListView extends StatefulWidget {
  const CollectionTaskListView({super.key});

  @override
  State<CollectionTaskListView> createState() => _CollectionTaskListViewState();
}

class _CollectionTaskListViewState extends State<CollectionTaskListView> with _CollectionTaskListViewMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CompleteTaskWidget(
          taskType: TaskType.collector,
        ),
        GestureDetector(
          onTap: () => context.router.push(ShopDetailRoute(shopId: 4643, taskId: 1)),
          child: CustomText(
            'Kutu Toplama',
            textStyle: context.general.textTheme.headlineSmall?.copyWith(),
          ),
        ),
        15.h.ph,
        BlocConsumer<TaskBloc, TaskState>(
          bloc: _taskBloc,
          listener: (context, state) {
            if (state is HandOverCollectorTaskSuccess) {
              _taskBloc.add(
                FetchCollectorTaskList(userId: context.read<AuthBloc>().state.user!.id!, cityId: 1, districtId: 1),
              );
              snackbarWidget(context, message: 'Görev başarıyla devredildi');
            } else if (state is HandOverCollectorTaskError) {
              _taskBloc.add(
                FetchCollectorTaskList(userId: context.read<AuthBloc>().state.user!.id!, cityId: 1, districtId: 1),
              );
              snackbarWidget(context, message: 'Görev devri sırasında bir hata oluştu', type: SnackbarType.error);
            }
          },
          builder: (context, state) {
            if (state is FetchingCollectorTaskList) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CollectorTaskListLoaded) {
              return state.responseModel != null
                  ? Column(
                      children: [
                        _UserCollectionInfoBoxWidget(state.responseModel),
                        15.h.ph,
                        GoogleMapWidget(
                          locations: _handleMarker(state.responseModel),
                        ),
                        15.h.ph,
                        _SearchableShopListWidget(
                          taskShops: state.responseModel?.taskShops,
                        ),
                      ],
                    )
                  : const Center(child: CustomText('Kutu toplama görevi bulunamadı.'));
            } else if (state is CollectorTaskListLoadError) {
              return Center(
                child: CustomText(
                  state.error,
                  textStyle: context.general.textTheme.headlineSmall?.copyWith(),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        15.h.ph,
      ],
    );
  }
}
