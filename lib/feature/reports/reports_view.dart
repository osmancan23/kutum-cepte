import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/address/address_bloc.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/base/service/address/address_service.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/cacheNetworkImage/cache_network_image_widget.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/image_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/report_type_enum.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/home/model/shop_by_user_model.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/date_select_widget.dart';
import 'package:kutum_cepte_app/feature/reports/bloc/report_bloc.dart';
import 'package:kutum_cepte_app/feature/reports/model/admin_report_list_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/daily_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/monthly_report_response_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/weekly_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/service/report_service.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
part 'widget/workerReportTable/worker_report_table_widget.dart';
part 'widget/adminReportTable/admin_report_table_widget.dart';
part 'widget/adminReportTable/widget/yearly_report_widget.dart';
part 'widget/adminReportTable/widget/other_report_widget.dart';
part 'widget/adminReportTable/widget/daily_report_widget.dart';
part 'widget/adminReportTable/widget/weekly_report_widget.dart';
part 'widget/adminReportTable/widget/monthly_report_widget.dart';
part 'widget/adminReportTable/widget/live_report_widget.dart';

@RoutePage()
class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<AuthBloc>().state.user?.role == 'ROLE_SUPER_ADMIN' ||
            context.read<AuthBloc>().state.user?.role == 'ROLE_ADMIN'
        ? const _AdminReportTableWidget()
        : const _WorkerReporTableWidget();
  }
}
