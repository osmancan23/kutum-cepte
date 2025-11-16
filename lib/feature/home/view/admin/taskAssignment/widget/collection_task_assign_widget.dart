part of '../view/task_assignment_view.dart';

class _HourSelectWidget extends StatelessWidget {
  const _HourSelectWidget({
    required this.viewModel,
  });
  final TaskAssignmentViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubtitleWidget(title: 'Başlangıç ve Bitiş Saati'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TimePickerWidget(
              onChange: (p0) {
                viewModel.startHour = p0.toString();
              },
            ),
            _TimePickerWidget(
              onChange: (p0) {
                viewModel.endHour = p0.toString();
              },
            ),
          ],
        ),
      ],
    );
  }
}
