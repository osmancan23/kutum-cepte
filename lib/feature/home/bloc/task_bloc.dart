import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/feature/home/model/admin_task_day_model.dart';
import 'package:kutum_cepte_app/feature/home/model/collector_task_response_model.dart';
import 'package:kutum_cepte_app/feature/home/model/create_collector_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/create_distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/live_tracking_model.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this._taskService) : super(TaskInitial()) {
    on<CreateCollectorTask>(_createCollectorTask);

    on<CreateDistirubutorTask>(_createDistirubutorTask);

    on<FetchCollectorTaskList>(_fetchCollectorTaskList);

    on<FetchDistributorTaskList>(_fetchDistributorTaskList);

    on<HandOverCollectorTask>(_handOverCollectorTask);

    on<HandOverDistributorTask>(_handOverDistributorTask);

    on<UpdateStreetListForDistributor>(_updateStreetListForDistributor);

    // ADMIN

    on<FetchTaskLiveTracking>(_fetchLiveTrackingData);

    on<FetchAdminTaskList>(_fetchAdminTaskList);

    on<DeleteDistributorTask>(_deleteDistributorTask);

    on<DeleteCollectorTask>(_deleteCollectorTask);

    on<FinishDistributorTask>(_finishDistributorTask);

    on<FinishCollectorTask>(_finishCollectorTask);
  }
  final ITaskService _taskService;

  Future<void> _createCollectorTask(CreateCollectorTask event, Emitter<TaskState> emit) async {
    emit(CreatingCollectorTask());

    final response = await _taskService.createTaskForCollector(event.createCollectorTaskModel);
    await response.fold(
      onSuccess: (success) {
        emit(CreatedCollectorTask());
      },
      onError: (error) {
        emit(TaskCreateError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _createDistirubutorTask(CreateDistirubutorTask event, Emitter<TaskState> emit) async {
    emit(CreatingDistirubutorTask());
    final response = await _taskService.createTaskForDistributor(event.createDistirubutorTaskModel);
    await response.fold(
      onSuccess: (success) {
        emit(CreatedDistirubutorTask());
      },
      onError: (error) {
        emit(TaskCreateError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _fetchCollectorTaskList(FetchCollectorTaskList event, Emitter<TaskState> emit) async {
    emit(FetchingCollectorTaskList());
    try {
      final response = await _taskService.fetchCollectorTaskList(
        userId: event.userId,
        cityId: event.cityId,
      );
      emit(CollectorTaskListLoaded(responseModel: response));
    } catch (e) {
      emit(CollectorTaskListLoadError(error: e.toString()));
    }
  }

  Future<void> _fetchDistributorTaskList(FetchDistributorTaskList event, Emitter<TaskState> emit) async {
    emit(FetchingDistributorTaskList());
    try {
      final response = await _taskService.fetchDistributorTaskList(userId: event.userId);
      emit(DistributorTaskListLoaded(taskList: response));
    } catch (e) {
      emit(DistributorTaskListLoadError(error: e.toString()));
    }
  }

  Future<void> _handOverCollectorTask(HandOverCollectorTask event, Emitter<TaskState> emit) async {
    emit(HandingOverCollectorTask());
    final response = await _taskService.handOverCollectorTask(userId: event.userId, taskId: event.taskId);
    await response.fold(
      onSuccess: (success) {
        emit(HandOverCollectorTaskSuccess());
      },
      onError: (error) {
        emit(HandOverCollectorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _handOverDistributorTask(HandOverDistributorTask event, Emitter<TaskState> emit) async {
    emit(HandingOverDistributorTask());
    final response = await _taskService.handOverDistributorTask(userId: event.userId, taskId: event.taskId);
    await response.fold(
      onSuccess: (success) {
        emit(HandOverDistributorTaskSuccess());
      },
      onError: (error) {
        emit(HandOverDistributorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _updateStreetListForDistributor(UpdateStreetListForDistributor event, Emitter<TaskState> emit) async {
    emit(UpdatingStreetListForDistributor());
    final response = await _taskService.updateStreetListForDistributor(
      taskId: event.taskId,
      streetList: event.streetList,
    );
    await response.fold(
      onSuccess: (success) {
        emit(UpdatedStreetListForDistributor());
      },
      onError: (error) {
        emit(TaskCreateError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  // ADMIN

  Future<void> _fetchLiveTrackingData(FetchTaskLiveTracking event, Emitter<TaskState> emit) async {
    emit(FetchingLiveTrackingData());
    try {
      final response = await _taskService.fetchLiveTrackingData(
        cityId: event.cityId,
        districtId: event.districtId,
        date: event.date,
      );
      emit(LiveTrackingDataLoaded(liveTrackingModel: response));
    } catch (e) {
      emit(LiveTrackingDataLoadError(error: e.toString()));
    }
  }

  Future<void> _fetchAdminTaskList(FetchAdminTaskList event, Emitter<TaskState> emit) async {
    emit(FetchingAdminTaskList());
    try {
      final response = await _taskService.fetchAdminTaskList();
      emit(AdminTaskListLoaded(adminTaskList: response));
    } catch (e) {
      emit(AdminTaskListLoadError(error: e.toString()));
    }
  }

  Future<void> _deleteDistributorTask(DeleteDistributorTask event, Emitter<TaskState> emit) async {
    emit(DeletingDistributorTask());
    final response = await _taskService.deleteDistributorTask(userId: event.taskId);
    await response.fold(
      onSuccess: (success) {
        emit(DeletedDistributorTask());
      },
      onError: (error) {
        emit(DeleteDistributorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _deleteCollectorTask(DeleteCollectorTask event, Emitter<TaskState> emit) async {
    emit(DeletingCollectorTask());
    final response = await _taskService.deleteCollectorTask(
      userId: event.adminTaskModel.userId!,
      cityId: event.adminTaskModel.sehirId!,
      districtId: event.adminTaskModel.ilceId!,
      date: event.date,
    );
    await response.fold(
      onSuccess: (success) {
        emit(DeletedCollectorTask());
      },
      onError: (error) {
        emit(DeleteCollectorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _finishCollectorTask(FinishCollectorTask event, Emitter<TaskState> emit) async {
    emit(FinishingCollectorTask());
    final response = await _taskService.finishCollectorTask(userId: event.userId);
    await response.fold(
      onSuccess: (success) {
        emit(FinishedCollectorTask());
      },
      onError: (error) {
        emit(FinishCollectorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }

  Future<void> _finishDistributorTask(FinishDistributorTask event, Emitter<TaskState> emit) async {
    emit(FinishingDistributorTask());
    final response = await _taskService.finishDistributorTask(userId: event.userId);
    await response.fold(
      onSuccess: (success) {
        emit(FinishedDistributorTask());
      },
      onError: (error) {
        emit(FinishDistributorTaskError(error: error.model?.message ?? 'Hata oluştu'));
      },
    );
  }
}
