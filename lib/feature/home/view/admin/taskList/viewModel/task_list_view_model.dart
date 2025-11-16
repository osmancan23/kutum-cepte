import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';

final class TaskListViewModel extends IBaseViewModel {
  late TaskBloc taskBloc;
  @override
  Future<void> init() {
    taskBloc = context!.read<TaskBloc>();
    taskBloc.add(FetchAdminTaskList());
    return Future.value();
  }

  @override
  void reset() {}
}
