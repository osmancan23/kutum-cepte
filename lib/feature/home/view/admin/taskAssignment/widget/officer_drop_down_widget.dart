part of '../view/task_assignment_view.dart';

class _OfficerDropDownWidget extends StatelessWidget {
  const _OfficerDropDownWidget({
    required this.viewModel,
  });
  final TaskAssignmentViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: viewModel.userBloc,
      builder: (context, state) {
        if (state is UserListLoadCompleted) {
          return DropdownButtonWidget(
            options: state.users.map((e) => '${e.name} ${e.surname}').toList(),
            hintText: 'Görevli Seçiniz',
            onChange: (p0) {
              viewModel.selectedUserId =
                  state.users.where((element) => ('${element.name} ${element.surname}') == p0).getIterableItem(0)?.id;
            },
          );
        } else if (state is UserListLoadError) {
          return const Center(child: CustomText('Kullanıcılar yüklenirken bir hata oluştu.'));
        } else if (state is UserListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const DropdownButtonWidget(
            options: ['Görevli A', 'Görevli B', 'Görevli C'],
            hintText: 'Görevli Adı Seçiniz',
          );
        }
      },
    );
  }
}
