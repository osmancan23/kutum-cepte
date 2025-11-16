import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/model/admin_task_day_model.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskList/viewModel/task_list_view_model.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';

part '../widget/task_expansion_tile_widget.dart';
part '../widget/delete_task_sheet.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: TaskListViewModel(),
      builder: (viewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Görev Listesi',
              textStyle: context.general.textTheme.headlineSmall,
            ),
            15.h.ph,
            CustomText(
              'Lütfen görev seçeneklerini belirleyerek görev atayın.',
              textStyle: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            BlocConsumer<TaskBloc, TaskState>(
              bloc: viewModel.taskBloc,
              listener: (context, state) {
                if (state is DeletedDistributorTask ||
                    state is DeletedCollectorTask ||
                    state is DeleteCollectorTaskError ||
                    state is DeleteDistributorTaskError) {
                  viewModel.taskBloc.add(FetchAdminTaskList());
                }
              },
              builder: (context, state) {
                if (state is AdminTaskListLoaded) {
                  return state.adminTaskList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.adminTaskList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final adminTaskDayModel = state.adminTaskList[index];
                            return Padding(
                              padding: context.padding.verticalLow,
                              child: _TaskExpansionTileWidget(
                                adminTaskDayModel: adminTaskDayModel,
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: const Center(child: CustomText('Görev bulunamadı.')),
                        );
                } else if (state is AdminTaskListLoadError) {
                  return const CustomText(
                    'Görevler yüklenirken bir hata oluştu.',
                  );
                } else if (state is FetchingAdminTaskList ||
                    state is DeletingCollectorTask ||
                    state is DeletingDistributorTask) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
