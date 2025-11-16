part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class CreatingCollectorTask extends TaskState {}

final class CreatedCollectorTask extends TaskState {}

final class CreatingDistirubutorTask extends TaskState {}

final class CreatedDistirubutorTask extends TaskState {}

final class TaskCreateError extends TaskState {
  TaskCreateError({required this.error});

  final String error;
}

final class FetchingCollectorTaskList extends TaskState {}

final class CollectorTaskListLoaded extends TaskState {
  CollectorTaskListLoaded({required this.responseModel});

  final CollectorTaskResponseModel? responseModel;
}

final class CollectorTaskListLoadError extends TaskState {
  CollectorTaskListLoadError({required this.error});

  final String? error;
}

final class FetchingDistributorTaskList extends TaskState {}

final class DistributorTaskListLoaded extends TaskState {
  DistributorTaskListLoaded({required this.taskList});

  final List<DistributorTaskModel> taskList;
}

final class DistributorTaskListLoadError extends TaskState {
  DistributorTaskListLoadError({required this.error});

  final String? error;
}

final class HandingOverCollectorTask extends TaskState {}

final class HandOverCollectorTaskSuccess extends TaskState {}

final class HandOverCollectorTaskError extends TaskState {
  HandOverCollectorTaskError({required this.error});

  final String? error;
}

final class HandingOverDistributorTask extends TaskState {}

final class HandOverDistributorTaskSuccess extends TaskState {}

final class HandOverDistributorTaskError extends TaskState {
  HandOverDistributorTaskError({required this.error});

  final String? error;
}

final class UpdatingStreetListForDistributor extends TaskState {}

final class UpdatedStreetListForDistributor extends TaskState {}

final class UpdateStreetListForDistributorError extends TaskState {
  UpdateStreetListForDistributorError({required this.error});
  final String? error;
}

// ADMIN

final class FetchingLiveTrackingData extends TaskState {}

final class LiveTrackingDataLoaded extends TaskState {
  LiveTrackingDataLoaded({required this.liveTrackingModel});

  final LiveTrackingModel? liveTrackingModel;
}

final class LiveTrackingDataLoadError extends TaskState {
  LiveTrackingDataLoadError({required this.error});

  final String? error;
}

final class FetchingAdminTaskList extends TaskState {}

final class AdminTaskListLoaded extends TaskState {
  AdminTaskListLoaded({required this.adminTaskList});

  final List<AdminTaskDayModel> adminTaskList;
}

final class AdminTaskListLoadError extends TaskState {
  AdminTaskListLoadError({required this.error});

  final String? error;
}

final class DeletingDistributorTask extends TaskState {}

final class DeletedDistributorTask extends TaskState {}

final class DeleteDistributorTaskError extends TaskState {
  DeleteDistributorTaskError({required this.error});

  final String? error;
}

final class DeletingCollectorTask extends TaskState {}

final class DeletedCollectorTask extends TaskState {}

final class DeleteCollectorTaskError extends TaskState {
  DeleteCollectorTaskError({required this.error});

  final String? error;
}

final class FinishingDistributorTask extends TaskState {}

final class FinishedDistributorTask extends TaskState {}

final class FinishDistributorTaskError extends TaskState {
  FinishDistributorTaskError({required this.error});

  final String? error;
}

final class FinishingCollectorTask extends TaskState {}

final class FinishedCollectorTask extends TaskState {}

final class FinishCollectorTaskError extends TaskState {
  FinishCollectorTaskError({required this.error});

  final String? error;
}
