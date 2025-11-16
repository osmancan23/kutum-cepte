part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class CreateCollectorTask extends TaskEvent {
  CreateCollectorTask({required this.createCollectorTaskModel});

  final CreateCollectorTaskModel createCollectorTaskModel;
}

final class CreateDistirubutorTask extends TaskEvent {
  CreateDistirubutorTask({required this.createDistirubutorTaskModel});

  final CreateDistributorTaskModel createDistirubutorTaskModel;
}

final class FetchCollectorTaskList extends TaskEvent {
  FetchCollectorTaskList({required this.userId, required this.cityId, required this.districtId});

  final int userId;
  final int cityId;
  final int districtId;
}

final class FetchDistributorTaskList extends TaskEvent {
  FetchDistributorTaskList({required this.userId});

  final int userId;
}

final class HandOverCollectorTask extends TaskEvent {
  HandOverCollectorTask({required this.userId, required this.taskId});

  final int userId;
  final int taskId;
}

final class HandOverDistributorTask extends TaskEvent {
  HandOverDistributorTask({required this.userId, required this.taskId});

  final int userId;
  final int taskId;
}

final class UpdateStreetListForDistributor extends TaskEvent {
  UpdateStreetListForDistributor({required this.taskId, required this.streetList});
  final int taskId;
  final Map<String, bool>? streetList;
}

final class FetchTaskLiveTracking extends TaskEvent {
  FetchTaskLiveTracking({required this.cityId, required this.districtId , required this.date});
  final int cityId;
  final int districtId;
  final DateTime? date;
}

final class FetchAdminTaskList extends TaskEvent {}

final class DeleteDistributorTask extends TaskEvent {
  DeleteDistributorTask({required this.taskId});
  final int taskId;
}

final class DeleteCollectorTask extends TaskEvent {
  DeleteCollectorTask({required this.adminTaskModel, this.date});
  final AdminTaskModel adminTaskModel;
  final String? date;
}

final class FinishDistributorTask extends TaskEvent {
  FinishDistributorTask({required this.userId});
  final int userId;
}

final class FinishCollectorTask extends TaskEvent {
  FinishCollectorTask({required this.userId});
  final int userId;
}
