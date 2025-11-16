part of '../collection_task_list_view.dart';

mixin _CollectionTaskListViewMixin on State<CollectionTaskListView> {
  late TaskBloc _taskBloc;
  late ShopBloc _shopBloc;
  final List<LatLng> _locations = [];

  late StreamSubscription<TaskState> _taskBlocSubscription;
  late StreamSubscription<ShopState> _shopBlocSubscription;

  @override
  void initState() {
    _taskBloc = context.read<TaskBloc>();
    _shopBloc = context.read<ShopBloc>();

    _shopBloc.stream.listen((event) {
      if (event is ShopHistoryCreated || event is ShopHistoryCreateError) {
        if (mounted) {
          _fetchCollectorTaskList();
        }
      }
    });
    _fetchCollectorTaskList();
    super.initState();

    _listenTaskBloc();

    _listenShopBloc();
  }

  void _fetchCollectorTaskList() {
    if (context.read<AuthBloc>().state.user == null) return;
    final user = context.read<AuthBloc>().state.user;
    _taskBloc.add(FetchCollectorTaskList(userId: user!.id!, cityId: user.sehirDto!.id!, districtId: user.ilceDto!.id!));
  }

  void _listenTaskBloc() {
    _taskBlocSubscription = _taskBloc.stream.listen((event) {
      if (event is CollectorTaskListLoaded) {
        log('Length: ${event.responseModel?.taskShops?.length}');
        if (event.responseModel?.taskShops != null) {
          event.responseModel?.taskShops?.forEach((element) {
            if (element.shopByTaskCollectorDto!.shopNo != -1) {
              _locations.add(
                LatLng(
                  double.parse(element.shopByTaskCollectorDto!.latitudeCordinate!),
                  double.parse(element.shopByTaskCollectorDto!.longitudeCordinate!),
                ),
              );
            }
          });
          setState(() {});
        }
      } else if (event is FinishedCollectorTask) {
        _fetchCollectorTaskList();
      }
    });
  }

  void _listenShopBloc() {
    _shopBlocSubscription = _shopBloc.stream.listen((event) {
      if (event is ShopUpdated) {
        _fetchCollectorTaskList();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _taskBlocSubscription.cancel();
      await _shopBlocSubscription.cancel();
    });
    super.dispose();
  }

  List<MarkerModel>? _handleMarker(CollectorTaskResponseModel? taskResponseModel) {
    return taskResponseModel!.taskShops
        ?.where((element) => element.shopByTaskCollectorDto?.shopNo != -1)
        .map(
          (e) => MarkerModel(
            id: e.shopByTaskCollectorDto?.id.toString(),
            latitude: e.shopByTaskCollectorDto!.latitudeCordinate!.toDouble,
            longitude: e.shopByTaskCollectorDto!.longitudeCordinate!.toDouble,
            title: '${e.shopByTaskCollectorDto?.title} (Dükkan No: ${e.shopByTaskCollectorDto?.shopNo})',
            markerType: (e.isActive ?? true) ? MarkerType.active : MarkerType.completed,
            shopNo: e.shopByTaskCollectorDto?.shopNo,
            taskId: e.taskId,
          ),
        )
        .toList();
  }
}
