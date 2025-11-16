part of "../../../reports_view.dart";
class _LiveReportWidget extends StatefulWidget {
  const _LiveReportWidget();

  @override
  State<_LiveReportWidget> createState() => _LiveReportWidgetState();
}

class _LiveReportWidgetState extends State<_LiveReportWidget> {
  late ReportBloc _reportBloc;
  late AddressBloc _addressBloc;
  @override
  void initState() {
    _addressBloc = AddressBloc(locator<AddressService>());
    _addressBloc.add(FetchCities());
    _reportBloc = ReportBloc(ReportService());
    _reportBloc.add(FetchAdminReportList(cityId: 1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddressDropDownButtonWidget(
            onChange: (value) {
              _reportBloc.add(FetchAdminReportList(cityId: value!.id!));
            },
            addressBloc: _addressBloc,
            type: AddressDropDownType.city,
          ),
          const SizedBox(height: 20),
          BlocBuilder<ReportBloc, ReportState>(
            bloc: _reportBloc,
            builder: (context, state) {
              if (state is AdminReportListCompleted) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      _buildTableColumn(context, title: 'İlçe'),
                      _buildTableColumn(context, title: 'Toplam K.S'),
                      _buildTableColumn(context, title: 'Toplanan K.S'),
                    ],
                    rows: state.adminReportList.map((row) => _buildDataRow(context, row)).toList(),
                    dataRowHeight: 30.h,
                    columnSpacing: 40.w,
                  ),
                );
              } else if (state is AdminReportListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: CustomText('Bir hata oluştu'));
              }
            },
          ),
        ],
      ),
    );
  }

  // Modelden bir DataRow oluşturuyoruz.
  DataRow _buildDataRow(BuildContext context, AdminReportListModel model) {
    // turuncu bir renk verelim
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
        _buildTableCell(context, text: model.ilce?.title ?? ''),
        _buildTableCell(context, text: (model.toplamKutu ?? 0).toString()),
        _buildTableCell(context, text: (model.toplananKutu ?? 0).toString()),
      ],
    );
  }

  // Tablo başlıkları için DataColumn oluşturuyoruz.
  DataColumn _buildTableColumn(BuildContext context, {required String title}) {
    return DataColumn(
      label: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  // Tablo hücresi için DataCell oluşturuyoruz.
  DataCell _buildTableCell(BuildContext context, {required String text}) => DataCell(
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}
