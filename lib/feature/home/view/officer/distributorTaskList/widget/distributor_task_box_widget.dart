part of '../distributor_task_list_view.dart';

class _DistributorTaskBoxWidget extends StatelessWidget {
  const _DistributorTaskBoxWidget(this.taskModel);
  final DistributorTaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.getBoxShadow,
        borderRadius: context.border.normalBorderRadius,
      ),
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _contentTile(
              context,
              title: 'Sorumlu',
              value: '${taskModel.adminUserInfoDto?.name} / ${taskModel.adminUserInfoDto?.surname}',
            ),
            _contentTile(
              context,
              title: 'İl / İlçe',
              value: '${taskModel.sehirDto?.title} / ${taskModel.ilceDto?.title}',
            ),
            _contentTile(
              context,
              title: 'Dağıtıcı',
              value: '${taskModel.userInfoDto?.name} ${taskModel.userInfoDto?.surname}',
            ),
            _contentTile(context, title: 'Bitirme Süresi', value: '${taskModel.time} Saat'),
            _contentTile(
              context,
              title: 'Başlama / Bitiş Süresi',
              value: '${taskModel.startTime?.toHourMinute} - ${taskModel.finishTime?.toHourMinute}',
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Sokak Bilgisi',
                  textStyle: context.general.textTheme.bodySmall?.copyWith(
                    color: context.general.colorScheme.onSurface,
                  ),
                ),
                _StreetListWidget(taskModel: taskModel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentTile(BuildContext context, {required String title, required String value}) {
    return Padding(
      padding: context.padding.verticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title,
            textStyle: context.general.textTheme.bodySmall?.copyWith(
              color: context.general.colorScheme.onSurface,
            ),
          ),
          CustomText(
            value,
            textStyle: context.general.textTheme.bodyMedium?.copyWith(),
          ),
        ],
      ),
    );
  }
}

class _StreetListWidget extends StatefulWidget {
  const _StreetListWidget({
    required this.taskModel,
  });

  final DistributorTaskModel taskModel;

  @override
  State<_StreetListWidget> createState() => _StreetListWidgetState();
}

class _StreetListWidgetState extends State<_StreetListWidget> {
  late TaskBloc _taskBloc;
  late Map<String, bool>? _streetList;
  late StreamSubscription<TaskState> _subscription;

  @override
  void initState() {
    _streetList = Map.from(widget.taskModel.sokaks ?? {});
    _taskBloc = TaskBloc(locator<TaskService>());
    _subscription = _taskBloc.stream.listen((event) {
      if (event is UpdatedStreetListForDistributor) {
        if (mounted) {
          snackbarWidget(context, message: 'Sokaklar güncellendi');
          widget.taskModel.sokaks = _streetList;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _taskBloc.close();
    super.dispose();
  }

  bool _hasChanges() {
    if (_streetList == null || widget.taskModel.sokaks == null) return false;
    for (final key in _streetList!.keys) {
      if (_streetList![key] != widget.taskModel.sokaks![key]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 150.w,
          child: ListView.builder(
            itemCount: widget.taskModel.sokaks?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final street = _streetList?.entries.elementAt(index);
              return Padding(
                padding: context.padding.verticalLow.copyWith(top: 3.h, bottom: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CheckboxWidget(
                      isLeft: false,
                      title: street?.key.toShortString(countCharacter: 15),
                      isChecked: street?.value,
                      onClick: (value) {
                        _streetList![street?.key ?? ''] = !_streetList![street!.key]!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (_hasChanges())
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _taskBloc.add(
                    UpdateStreetListForDistributor(
                      taskId: widget.taskModel.id!,
                      streetList: _streetList,
                    ),
                  );
                },
                child: CustomText(
                  'Güncelle',
                  textStyle: context.general.textTheme.bodyMedium?.copyWith(
                    color: context.general.colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
