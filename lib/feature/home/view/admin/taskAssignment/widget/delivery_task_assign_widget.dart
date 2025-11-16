part of '../view/task_assignment_view.dart';

class _CollectionTaskAssignWidget extends StatelessWidget {
  const _CollectionTaskAssignWidget({
    required this.viewModel,
  });

  final TaskAssignmentViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubtitleWidget(title: 'Dükkan No Aralığı'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormFieldWidget(
              width: 180,
              hintText: 'Başlangıç',
              textInputType: TextInputType.number,
              onChange: (val) {
                viewModel.boxNoStart = int.tryParse(val);
              },
            ),
            TextFormFieldWidget(
              width: 180,
              hintText: 'Bitiş',
              textInputType: TextInputType.number,
              onChange: (val) {
                viewModel.boxNoEnd = int.tryParse(val);
              },
            ),
          ],
        ),
      ],
    );
  }
}
