import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/checkBox/checkbox.dart';
import 'package:kutum_cepte_app/core/components/snackbar/snackbar.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/navigation/routes.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/model/distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/shop_by_user_model.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';
import 'package:kutum_cepte_app/feature/home/view/widget/complete_task_widget.dart';
import 'package:kutum_cepte_app/feature/reports/bloc/report_bloc.dart';
import 'package:kutum_cepte_app/feature/reports/service/report_service.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';
part 'widget/distributor_task_box_widget.dart';
part 'mixin/distributor_task_list_view_mixin.dart';
part 'widget/added_box_widget.dart';

final class DistributorTaskListView extends StatefulWidget {
  const DistributorTaskListView({super.key});

  @override
  State<DistributorTaskListView> createState() => _DistributorTaskListViewState();
}

class _DistributorTaskListViewState extends State<DistributorTaskListView> with _DistributorTaskListViewMixin {
  late ReportBloc _reportBloc;
  final DateTime _date = DateTime.now();

  @override
  void initState() {
    _reportBloc = ReportBloc(ReportService());
    _reportBloc.add(
      FetchWorkerReportList(
        context.read<AuthBloc>().state.user!.id!,
        _date.formattedDate,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CompleteTaskWidget(
          taskType: TaskType.distributor,
        ),
        15.h.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Dükkan Bilgileri',
              textStyle: context.general.textTheme.headlineSmall?.copyWith(),
            ),
            ButtonWidget(
              onTap: () => context.router.push(const ShopCreateRoute()),
              text: 'Kutu Ekle',
              width: 120,
              height: 40,
              radius: 12,
            ),
          ],
        ),
        15.h.ph,
        _DistributorTaskListWidget(taskBloc: _taskBloc),
        15.h.ph,
        const _AddedBoxsWidget(),
      ],
    );
  }
}

class _DistributorTaskListWidget extends StatelessWidget {
  const _DistributorTaskListWidget({
    required TaskBloc taskBloc,
  }) : _taskBloc = taskBloc;

  final TaskBloc _taskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _taskBloc,
      builder: (context, state) {
        if (state is FetchingDistributorTaskList) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DistributorTaskListLoaded) {
          return state.taskList.isNotEmpty
              ? ListView.builder(
                  itemCount: state.taskList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final taskModel = state.taskList[index];
                    return Padding(
                      padding: context.padding.verticalLow,
                      child: _DistributorTaskBoxWidget(taskModel),
                    );
                  },
                )
              : const Center(child: CustomText('Henüz görev atanmamış'));
        } else {
          return const Center(child: CustomText('Bir hata oluştu'));
        }
      },
    );
  }
}
