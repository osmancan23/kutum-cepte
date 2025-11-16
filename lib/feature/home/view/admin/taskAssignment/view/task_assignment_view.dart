import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/user/user_bloc.dart';
import 'package:kutum_cepte_app/core/base/view/i_base_view.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/dropdownButtonWidget/dropdown_button_widget.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/components/textFormField/text_form_field_widget.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';

import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/viewModel/task_assignment_view_model.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/address_drop_down_widget.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/widget/date_select_widget.dart';
import 'package:kutum_cepte_app/product/widget/choiseStreet/choise_street_widget.dart';
import 'package:kutum_cepte_app/product/widget/googleMap/google_map_widget.dart';
import 'package:kutum_cepte_app/utils/extension/iterable_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

part '../widget/time_picker_widget.dart';
part '../widget/collection_task_assign_widget.dart';
part '../widget/delivery_task_assign_widget.dart';

part '../widget/officer_drop_down_widget.dart';

class TaskAssignmentView extends StatelessWidget {
  const TaskAssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView(
      viewModel: TaskAssignmentViewModel(),
      builder: (viewModel) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Görev Atama',
                textStyle: context.general.textTheme.headlineSmall,
              ),
              15.h.ph,
              CustomText(
                'Lütfen görev seçeneklerini belirleyerek görev atayın.',
                textStyle: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              10.h.ph,
              const _SubtitleWidget(title: 'Şehir'),
              AddressDropDownButtonWidget(
                type: AddressDropDownType.city,
                addressBloc: viewModel.cityBloc,
                onChange: (value) => viewModel.selectCity(value),
              ),
              const _SubtitleWidget(title: 'İlçe'),
              AddressDropDownButtonWidget(
                type: AddressDropDownType.district,
                addressBloc: viewModel.districtBloc,
                onChange: viewModel.selectDistrict,
              ),
              const _SubtitleWidget(title: 'Görevi'),
              DropdownButtonWidget(
                options: TaskType.values.map((e) => e.title).toList(),
                hintText: 'Görev Seçiniz',
                value: viewModel.taskType.title,
                onChange: (p0) {
                  viewModel.taskType = TaskType.values.firstWhere((element) => element.title == p0.toString());
                },
              ),
              if (viewModel.taskType == TaskType.distributor)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SubtitleWidget(title: 'Sokak'),
                    ChoiseStreetWidget(
                      textEditingController: viewModel.streetController,
                      streetList: viewModel.streetList,
                      onTapSave: () {
                        viewModel.street = '';
                      },
                      onTapDelete: () {
                        viewModel.street = '';
                      },
                    ),
                  ],
                ),
              const _SubtitleWidget(title: 'Görevli Adı Soyadı'),
              _OfficerDropDownWidget(viewModel: viewModel),
              const _SubtitleWidget(title: 'Tarih'),
              DateSelectWidget(
                onChange: (value) {
                  viewModel.date = value;
                },
              ),
              _HourSelectWidget(viewModel: viewModel),
              if (viewModel.taskType == TaskType.collector)
                Column(
                  children: [
                    _CollectionTaskAssignWidget(viewModel: viewModel),
                    10.h.ph,
                    GoogleMapWidget(
                      locations: viewModel.locations,
                    ),
                  ],
                ),
              20.h.ph,
              ButtonWidget(
                text: 'Kaydet',
                onTap: () => viewModel.createTask(),
              ),
              20.h.ph,
            ],
          ),
        );
      },
    );
  }
}

class _SubtitleWidget extends StatelessWidget {
  const _SubtitleWidget({
    this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.h.ph,
        CustomText(
          title,
          textStyle: context.general.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        10.h.ph,
      ],
    );
  }
}
