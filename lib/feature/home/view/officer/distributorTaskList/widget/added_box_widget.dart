part of '../distributor_task_list_view.dart';

class _AddedBoxsWidget extends StatefulWidget {
  const _AddedBoxsWidget();

  @override
  State<_AddedBoxsWidget> createState() => _AddedBoxsWidgetState();
}

class _AddedBoxsWidgetState extends State<_AddedBoxsWidget> {
  late ReportBloc _reportBloc;
  final DateTime _date = DateTime.now();

  @override
  void initState() {
    _reportBloc = ReportBloc(ReportService());
    _reportBloc.add(
      FetchWorkerReportList(
        context.read<AuthBloc>().state.user!.id!,
        _date.formattedDate,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              'Eklenen Kutular',
              textStyle: context.general.textTheme.headlineSmall?.copyWith(),
            ),
          ],
        ),
        10.h.ph,
        BlocBuilder<ReportBloc, ReportState>(
          bloc: _reportBloc,
          builder: (context, state) {
            if (state is WorkerReportListCompleted && (state.workerReport.distributorShops?.isNotEmpty ?? false)) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.workerReport.distributorShops?.length,
                itemBuilder: (context, index) {
                  final shop = state.workerReport.distributorShops?[index];
                  return _AddedBoxTileWidget(shop);
                },
              );
            } else if (state is WorkerReportListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkerReportListError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

class _AddedBoxTileWidget extends StatelessWidget {
  const _AddedBoxTileWidget(this.shop);
  final ShopByUserModel? shop;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: context.border.normalBorderRadius,
            boxShadow: context.getBoxShadow,
          ),
          child: ListTile(
            onTap: () => context.router.push(
              ShopDetailRoute(
                shopId: shop?.id ?? 0,
              ),
            ),
            title: CustomText(
              shop?.title ?? '',
              minFontSize: 20,
              textStyle: context.general.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: SizedBox(
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    shop?.boxCount?.toString() ?? '0',
                    minFontSize: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.general.colorScheme.primary,
                  ),
                ],
              ),
            ),
            subtitle: CustomText(
              "${shop?.sehirDto?.title ?? 'Unknown City'} / ${shop?.ilceDto?.title ?? 'Unknown District'}",
              textStyle: context.general.textTheme.bodySmall?.copyWith(
                color: context.general.colorScheme.secondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
