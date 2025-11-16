import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/base/bloc/auth/auth_bloc.dart';
import 'package:kutum_cepte_app/core/components/bottomSheet/bottom_sheet.dart';
import 'package:kutum_cepte_app/core/components/button/button.dart';
import 'package:kutum_cepte_app/core/components/svgPicture/svg_image.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/icon_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/task_type_enum.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/utils/extension/context_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/num_extensions.dart';

class CompleteTaskWidget extends StatelessWidget {
  const CompleteTaskWidget({
    required this.taskType,
    super.key,
  });
  final TaskType taskType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonWidget(
          width: 180,
          height: 40,
          text: 'Görevleri Tamamla',
          onTap: () => _areYouSureBottomSheet(context, type: taskType),
        ),
      ],
    );
  }
}

Future<dynamic> _areYouSureBottomSheet(BuildContext context, {required TaskType type}) {
  return showBottomSheetWidget(
    context,
    body: Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: Column(
        children: [
          SvgImageWidget(
            icon: IconEnums.warning,
            iconSize: 50.w,
          ),
          10.h.ph,
          CustomText(
            'Görevleri tamamlayacaksın, emin misin?',
            textStyle: context.general.textTheme.headlineMedium?.copyWith(),
          ),
          SizedBox(
            width: 250.w,
            child: CustomText(
              'Görevleri tamamladıktan sonra tekrar geri alamazsın.',
              textStyle: context.general.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400, color: context.general.colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
          ),
          16.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                onTap: () => context.closePopup(),
                text: 'Vazgeç',
                width: 180,
                radius: 16,
                buttonColor: context.general.colorScheme.error,
              ),
              16.h.ph,
              ButtonWidget(
                onTap: () {
                  if (type == TaskType.collector) {
                    context.read<TaskBloc>().add(FinishCollectorTask(userId: context.read<AuthBloc>().state.user!.id!));
                  } else {
                    context
                        .read<TaskBloc>()
                        .add(FinishDistributorTask(userId: context.read<AuthBloc>().state.user!.id!));
                  }
                  context.closePopup();
                },
                text: 'Tamamla',
                width: 180,
                radius: 16,
              ),
            ],
          ),
          16.h.ph,
        ],
      ),
    ),
  );
}
