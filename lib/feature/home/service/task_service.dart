import 'package:kutum_cepte_app/core/base/model/base_error_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_list_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/home/model/admin_task_day_model.dart';
import 'package:kutum_cepte_app/feature/home/model/collector_task_response_model.dart';
import 'package:kutum_cepte_app/feature/home/model/create_collector_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/create_distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/distributor_task_model.dart';
import 'package:kutum_cepte_app/feature/home/model/live_tracking_model.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:kutum_cepte_app/utils/typedefs/typedefs.dart';
import 'package:vexana/vexana.dart';

abstract class ITaskService {
  ITaskService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  //Collector
  Future<BaseResult> createTaskForCollector(CreateCollectorTaskModel model);

  Future<CollectorTaskResponseModel?> fetchCollectorTaskList({
    required int userId,
    required int cityId,
  });

  Future<BaseResult> handOverCollectorTask({required int userId, required int taskId});

  //Distributor
  Future<BaseResult> createTaskForDistributor(CreateDistributorTaskModel model);

  Future<List<DistributorTaskModel>> fetchDistributorTaskList({required int userId});

  Future<BaseResult> handOverDistributorTask({required int userId, required int taskId});

  Future<BaseResult> updateStreetListForDistributor({required int taskId, required Map<String, bool>? streetList});

  // ADMIN

  Future<LiveTrackingModel?> fetchLiveTrackingData({required int cityId, required int districtId, DateTime? date});

  Future<List<AdminTaskDayModel>> fetchAdminTaskList();

  Future<BaseResult> deleteDistributorTask({required int userId});

  Future<BaseResult> deleteCollectorTask({
    required int userId,
    required int cityId,
    required int districtId,
    required String? date,
  });

  Future<BaseResult> finishDistributorTask({required int userId});

  Future<BaseResult> finishCollectorTask({required int userId});
}

class TaskService extends ITaskService {
  TaskService();

  @override
  Future<BaseResult> createTaskForCollector(CreateCollectorTaskModel model) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.createTaskForCollector.key,
      parseModel: const BaseModel(),
      method: RequestType.POST,
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<BaseResult> createTaskForDistributor(
    CreateDistributorTaskModel model,
  ) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.createTaskForDistributor.key,
      parseModel: const BaseModel(),
      method: RequestType.POST,
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<CollectorTaskResponseModel?> fetchCollectorTaskList({
    required int userId,
    required int cityId,
  }) async {
    final response = await _networkManager
        .send<BaseResponseModel<CollectorTaskResponseModel>, BaseResponseModel<CollectorTaskResponseModel>>(
      NetworkEnums.collectorTaskList.key + userId.toString(),
      parseModel: const BaseResponseModel(parseModel: CollectorTaskResponseModel()),
      method: RequestType.POST,
      queryParameters: {
        'date': DateTime.now().formattedDate,
      },
      data: {
        'sehirId': cityId,
      },
    );

    return response.data?.data;
  }

  @override
  Future<List<DistributorTaskModel>> fetchDistributorTaskList({required int userId}) async {
    final response = await _networkManager
        .send<BaseResponseListModel<DistributorTaskModel>, BaseResponseListModel<DistributorTaskModel>>(
      NetworkEnums.distributorTaskList.key + userId.toString(),
      parseModel: BaseResponseListModel(parseModel: DistributorTaskModel()),
      method: RequestType.GET,
      queryParameters: {
        'date': DateTime.now().formattedDate,
      },
    );

    return response.data?.data ?? [];
  }

  @override
  Future<BaseResult> handOverCollectorTask({required int userId, required int taskId}) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.handOverCollectorTask.key,
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: {
        'userId': userId,
        'taskId': taskId,
      },
    );

    return response;
  }

  @override
  Future<BaseResult> handOverDistributorTask({
    required int userId,
    required int taskId,
  }) async {
    final response = await _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.handOverDistributorTask.key,
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: {
        'userId': userId,
        'taskId': taskId,
      },
    );

    return response;
  }

  @override
  Future<BaseResult> updateStreetListForDistributor({required int taskId, required Map<String, bool>? streetList}) {
    final response = _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.updateStreetListForDistributor.key + taskId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
      data: streetList,
    );
    return response;
  }

  @override
  Future<LiveTrackingModel?> fetchLiveTrackingData({
    required int cityId,
    required int districtId,
    DateTime? date,
  }) async {
    final response =
        await _networkManager.send<BaseResponseModel<LiveTrackingModel>, BaseResponseModel<LiveTrackingModel>>(
      NetworkEnums.liveTracking.key,
      parseModel: const BaseResponseModel(parseModel: LiveTrackingModel()),
      method: RequestType.POST,
      queryParameters: {
        'date': date?.formattedDate,
      },
      data: {
        'sehirId': cityId,
        'ilceId': districtId,
      },
    );

    return response.data?.data;
  }

  @override
  Future<List<AdminTaskDayModel>> fetchAdminTaskList() async {
    final response =
        await _networkManager.send<BaseResponseListModel<AdminTaskDayModel>, BaseResponseListModel<AdminTaskDayModel>>(
      NetworkEnums.adminTaskList.key,
      parseModel: const BaseResponseListModel(parseModel: AdminTaskDayModel()),
      method: RequestType.GET,
      queryParameters: {
        'date': DateTime.now().formattedDate,
      },
    );

    return response.data?.data ?? [];
  }

  @override
  Future<BaseResult> deleteCollectorTask({
    required int userId,
    required int cityId,
    required int districtId,
    required String? date,
  }) {
    final response = _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.deleteCollectorTask.key,
      parseModel: const BaseModel(),
      method: RequestType.DELETE,
      data: {
        'date': date,
        'userId': userId.toString(),
        'sehirId': cityId.toString(),
        'ilceId': districtId,
      },
    );
    return response;
  }

  @override
  Future<BaseResult> deleteDistributorTask({required int userId}) {
    final response = _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.deleteDistributorTask.key + userId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.DELETE,
    );
    return response;
  }

  @override
  Future<BaseResult> finishCollectorTask({required int userId}) {
    final response = _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.finishCollectorTask.key + userId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
    );
    return response;
  }

  @override
  Future<BaseResult> finishDistributorTask({required int userId}) {
    final response = _networkManager.sendRequest<BaseModel, BaseModel>(
      NetworkEnums.finishDistributorTask.key + userId.toString(),
      parseModel: const BaseModel(),
      method: RequestType.PUT,
    );
    return response;
  }
}
