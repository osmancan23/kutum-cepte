part of '../../reports_view.dart';

class _WorkerReporTableWidget extends StatefulWidget {
  const _WorkerReporTableWidget();

  @override
  State<_WorkerReporTableWidget> createState() => _WorkerReporTableWidgetState();
}

class _WorkerReporTableWidgetState extends State<_WorkerReporTableWidget> {
  late ReportBloc _reportBloc;
  DateTime? _date = DateTime.now();

  @override
  void initState() {
    _reportBloc = ReportBloc(ReportService());
    _reportBloc.add(FetchWorkerReportList(context.read<AuthBloc>().state.user!.id!, _date!.formattedDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateSelectWidget(
          onChange: (date) {
            _date = date;
            if (context.mounted) {
              _reportBloc.add(FetchWorkerReportList(context.read<AuthBloc>().state.user!.id!, _date!.formattedDate));
            }
            setState(() {});
          },
        ),
        BlocBuilder<ReportBloc, ReportState>(
          bloc: _reportBloc,
          builder: (context, state) {
            if (state is WorkerReportListCompleted) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    _buildTableColumn(context, title: 'Dükkan İsmi'),
                    _buildTableColumn(context, title: 'İl'),
                    _buildTableColumn(context, title: 'İlçe'),
                    _buildTableColumn(context, title: 'Kutu Sayısı'),
                  ],
                  rows: state.workerReport.distributorShops?.map((row) => _buildDataRow(context, row)).toList() ?? [],
                ),
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

  DataRow _buildDataRow(BuildContext context, ShopByUserModel model) {
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          return Theme.of(context).colorScheme.primary.withOpacity(0.04);
        },
      ),
      cells: [
        _buildShopTitle(model, context),
        _buildTableCell(context, text: model.sehirDto?.title ?? '-'),
        _buildTableCell(context, text: model.ilceDto?.title ?? '-'),
        _buildTableCell(context, text: (model.boxCount ?? 0).toString()),
      ],
    );
  }

  DataCell _buildShopTitle(ShopByUserModel model, BuildContext context) {
    return DataCell(
      Text(
        model.title ?? '-',
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: context.general.colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => context.router.push(ShopDetailRoute(shopId: model.id!)),
    );
  }

  DataColumn _buildTableColumn(BuildContext context, {required String title}) {
    return DataColumn(
      label: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  DataCell _buildTableCell(BuildContext context, {required String text}) => DataCell(
        Text(text),
      );
}
