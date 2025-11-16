import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/liveTracking/viewModel/live_tracking_view_model.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/liveTracking/widget/chart_widget.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/liveTracking/widget/select_location_widget.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/date_select_widget.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

class LiveTrackingView extends StatelessWidget {
  const LiveTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: LiveTrackingViewModel(),
      builder: (viewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Lokasyon',
              textStyle: context.general.textTheme.headlineSmall,
            ),
            15.h.ph,
            SelectLocationWidget(
              onSelect: (cityId, districtId) {
                viewModel
                  ..cityId = cityId
                  ..districtId = districtId;
              },
            ),
            15.h.ph,
            CustomText(
              'Tarih',
              textStyle: context.general.textTheme.headlineSmall,
            ),
            15.h.ph,
            DateSelectWidget(
              // 2024
              initialDate: DateTime.now().subtract(const Duration(days: 100)),
              onChange: (value) {
                viewModel.date = value;
              },
            ),
            15.h.ph,
            ButtonWidget(onTap: viewModel.fetchLiveTracking, text: 'Görev Atamalarını Getir'),
            20.h.ph,
            GoogleMapWidget(
              locations: viewModel.markers,
            ),
            20.h.ph,
            ChartWidget(
              completePercent: viewModel.collectedPercent,
              waitingPercent: viewModel.waitingPercent,
            ),
          ],
        );
      },
    );
  }
}
