part of '../distributor_task_list_view.dart';

mixin _DistributorTaskListViewMixin on State<DistributorTaskListView> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add(
      FetchDistributorTaskList(
        userId: context.read<AuthBloc>().state.user!.id!,
      ),
    );
    super.initState();

    _listenTaskBloc();
  }

  void _listenTaskBloc() {
    _taskBloc.stream.listen((event) {
      if (event is FinishedDistributorTask) {
        if (mounted) {
          _taskBloc.add(
            FetchDistributorTaskList(
              userId: context.read<AuthBloc>().state.user!.id!,
            ),
          );
        }
      }
    });
  }
}
