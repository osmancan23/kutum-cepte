part of '../../../reports_view.dart';

class _DailyReportWidget extends StatefulWidget {
  const _DailyReportWidget();

  @override
  State<_DailyReportWidget> createState() => _DailyReportWidgetState();
}

class _DailyReportWidgetState extends State<_DailyReportWidget> {
  TaskType selectedRole = TaskType.collector;
  late ReportBloc _reportBloc;
  DateTime startDate = DateTime.now().add(const Duration(days: -1));
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    _reportBloc = ReportBloc(ReportService());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                'Görevli Tipi',
                textStyle: context.general.textTheme.bodyMedium?.copyWith(
                  color: context.general.colorScheme.primary,
                ),
              ),
            ],
          ),
          10.h.ph,
          DropdownButtonWidget(
            width: 250,
            options: TaskType.values.map((e) => e.title).toList(),
            value: selectedRole.title,
            onChange: (p0) {
              setState(() {
                selectedRole = TaskType.values.firstWhere((element) => element.title == p0);
              });
            },
          ),
          20.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Başlangıç Tarih Seçiniz',
                    textStyle: context.general.textTheme.bodyMedium?.copyWith(
                      color: context.general.colorScheme.primary,
                    ),
                  ),
                  10.h.ph,
                  DateSelectWidget(
                    width: 180,
                    onChange: (value) {
                      setState(() {
                        startDate = value!;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Bitiş Tarih Seçiniz',
                    textStyle: context.general.textTheme.bodyMedium?.copyWith(
                      color: context.general.colorScheme.primary,
                    ),
                  ),
                  10.h.ph,
                  DateSelectWidget(
                    width: 180,
                    initialDate: DateTime.now().subtract(const Duration(days: 365)),
                    onChange: (value) {
                      setState(() {
                        endDate = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          20.h.ph,
          ButtonWidget(
            onTap: () {
              if (selectedRole == TaskType.collector) {
                _reportBloc.add(FetchCollectorDailyReportList(ReportTypeEnum.daily, startDate, endDate));
              } else {
                _reportBloc.add(FetchDistributorDailyReportList(ReportTypeEnum.daily, startDate, endDate));
              }
            },
            text: 'Raporu Getir',
          ),
          10.h.ph,
          if (selectedRole == TaskType.collector)
            BlocBuilder<ReportBloc, ReportState>(
              bloc: _reportBloc,
              builder: (context, state) {
                if (state is CollectorDailyReportListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CollectorDailyReportListError) {
                  return Center(
                    child: CustomText(
                      state.message,
                      textStyle: context.general.textTheme.bodySmall?.copyWith(
                        color: context.general.colorScheme.error,
                      ),
                    ),
                  );
                } else if (state is CollectorDailyReportListCompleted) {
                  return state.dailyReportList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.dailyReportList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final dailyReportModel = state.dailyReportList[index];
                            return _CollectorDailyItemWidget(dailyReportModel: dailyReportModel);
                          },
                        )
                      : Center(
                          child: Column(
                            children: [
                              200.h.ph,
                              CustomText(
                                'Günlük Toplayıcı Raporu Bulunamadı',
                                textStyle: context.general.textTheme.bodyMedium?.copyWith(),
                              ),
                            ],
                          ),
                        );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          if (selectedRole == TaskType.distributor)
            BlocBuilder<ReportBloc, ReportState>(
              bloc: _reportBloc,
              builder: (context, state) {
                if (state is DistributorDailyReportListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DistributorDailyReportListError) {
                  return Center(
                    child: CustomText(
                      state.message,
                      textStyle: context.general.textTheme.bodySmall?.copyWith(
                        color: context.general.colorScheme.error,
                      ),
                    ),
                  );
                } else if (state is DistributorDailyReportListCompleted) {
                  return state.dailyReportList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.dailyReportList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final dailyReportModel = state.dailyReportList[index];
                            return _DistributorDailyItemWidget(dailyReportModel: dailyReportModel);
                          },
                        )
                      : Center(
                          child: Column(
                            children: [
                              200.h.ph,
                              CustomText(
                                'Günlük Dağıtıcı Raporu Bulunamadı',
                                textStyle: context.general.textTheme.bodyMedium?.copyWith(),
                              ),
                            ],
                          ),
                        );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
        ],
      ),
    );
  }
}

class _CollectorDailyItemWidget extends StatelessWidget {
  const _CollectorDailyItemWidget({
    required this.dailyReportModel,
  });

  final DailyReportModel dailyReportModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.general.colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 35,
            backgroundColor: context.general.colorScheme.secondary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: dailyReportModel.avatarUrl != null
                  ? CacheNetworkImageWidget(imageUrl: dailyReportModel.avatarUrl!)
                  : Image.asset(ImageEnums.logo.pngPath),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  dailyReportModel.userName,
                ),
                CustomText(dailyReportModel.ilceName),
                CustomText(dailyReportModel.totalHoursWorked),
                CustomText(
                  '${(dailyReportModel.totalIade ?? 0) + (dailyReportModel.totalKayipKutu ?? 0) + (dailyReportModel.totalKapaliDukkan ?? 0)}/${dailyReportModel.totalUniqueShopCount}',
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const CustomText(
                      'Kayıp Kutu: ',
                    ),
                    CustomText((dailyReportModel.totalKayipKutu ?? 0).toString()),
                  ],
                ),
                Row(
                  children: [
                    const CustomText(
                      'Kapalı Dükkan: ',
                    ),
                    CustomText((dailyReportModel.totalKapaliDukkan ?? 0).toString()),
                  ],
                ),
                Row(
                  children: [
                    const CustomText('İade: '),
                    CustomText((dailyReportModel.totalIade ?? 0).toString()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _DistributorDailyItemWidget extends StatelessWidget {
  const _DistributorDailyItemWidget({
    required this.dailyReportModel,
  });

  final DailyReportModel dailyReportModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.general.colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 35,
            backgroundColor: context.general.colorScheme.secondary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: dailyReportModel.avatarUrl != null
                  ? CacheNetworkImageWidget(imageUrl: dailyReportModel.avatarUrl!)
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                dailyReportModel.userName,
              ),
              CustomText(dailyReportModel.ilceName),
              CustomText(
                'Süre: ${dailyReportModel.totalHoursWorked}',
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomText('Dağıtılan Kutu'),
              CustomText(
                (dailyReportModel.totalUniqueShopCount ?? 0).toString(),
              ),
              const CustomText('Dükkan Sayısı'),
              CustomText(
                (dailyReportModel.totalDistributedBoxes ?? 0).toString(),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
