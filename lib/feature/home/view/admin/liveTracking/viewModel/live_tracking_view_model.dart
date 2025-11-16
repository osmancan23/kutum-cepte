import 'dart:async';

import 'package:kutum_cepte_app/core/base/model/marker_model.dart';
import 'package:kutum_cepte_app/core/base/viewModel/i_base_viewmodel.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/bloc/task_bloc.dart';
import 'package:kutum_cepte_app/feature/home/model/live_tracking_model.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

part '../mixin/live_tracking_view_mixin.dart';

final class LiveTrackingViewModel extends IBaseViewModel with _LiveTrackingViewMixin {
  late TaskBloc _taskBloc;
  late StreamSubscription<TaskState> _taskSubscription;

  @override
  Future<void> init() {
    _taskBloc = TaskBloc(locator<TaskService>());
    _taskSubscription = _taskBloc.stream.listen((state) {
      if (state is LiveTrackingDataLoaded) {
        _handleMarkers(state.liveTrackingModel);
        collectedPercent = state.liveTrackingModel?.collected;
        waitingPercent = state.liveTrackingModel?.notCollected;
      }
    });
    return Future.value();
  }

  void _handleMarkers(LiveTrackingModel? model) {
    markers = model?.collectorTask
        ?.map(
          (e) => MarkerModel(
            latitude: e.shopByTaskCollectorDto!.latitudeCordinate!.toDouble,
            longitude: e.shopByTaskCollectorDto!.longitudeCordinate!.toDouble,
            title: e.shopByTaskCollectorDto?.title,
            id: e.shopByTaskCollectorDto?.id.toString(),
            markerType: e.isActive ?? true ? MarkerType.active : MarkerType.completed,
          ),
        )
        .toList();
  }

  @override
  void reset() {
    _taskSubscription.cancel();
    _taskBloc.close();
  }

  void fetchLiveTracking() {
    try {
      if (cityId != null && districtId != null) {
        _taskBloc.add(FetchTaskLiveTracking(cityId: cityId!, districtId: districtId!, date: date ?? DateTime.now()));
      }
    } catch (e, stackTrace) {
      rethrow; // Hatanın yukarıya doğru iletilmesini sağlar
    }
  }
}
