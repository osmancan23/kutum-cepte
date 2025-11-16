part of '../../../reports_view.dart';

class _MonthlyReportWidget extends StatefulWidget {
  const _MonthlyReportWidget();

  @override
  State<_MonthlyReportWidget> createState() => _MonthlyReportWidgetState();
}

class _MonthlyReportWidgetState extends State<_MonthlyReportWidget> {
  late AddressBloc _addressBloc;
  late ReportBloc _reportBloc;
  @override
  void initState() {
    _addressBloc = AddressBloc(locator<AddressService>());
    _reportBloc = ReportBloc(ReportService());
    _addressBloc.add(FetchCities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressDropDownButtonWidget(
          onChange: (value) {
            if (value != null) {
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);
              _reportBloc.add(
                FetchMonthlyReport(
                  value.id!,
                  startOfMonth,
                  endOfMonth,
                ),
              );
            }
          },
          addressBloc: _addressBloc,
          type: AddressDropDownType.city,
        ),
        30.h.ph,
        BlocBuilder<ReportBloc, ReportState>(
          bloc: _reportBloc,
          builder: (context, state) {
            if (state is MonthlyReportCompleted) {
              return _ChartAndInfoWidget(monthlyReport: state.monthlyReport);
            } else if (state is MonthlyReportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MonthlyReportError) {
              return const Center(child: CustomText('Bir hata oluştu'));
            } else {
              return const Center(child: CustomText('İl seçiniz'));
            }
          },
        ),
      ],
    );
  }
}

class _ChartAndInfoWidget extends StatelessWidget {
  const _ChartAndInfoWidget({
    required this.monthlyReport,
  });

  final MonthlyReportResponseModel monthlyReport;

  @override
  Widget build(BuildContext context) {
    final toplananYuzde = monthlyReport.hedef != 0
        ? (((monthlyReport.hedef ?? 0) - (monthlyReport.toplanmayan ?? 0)) / (monthlyReport.hedef ?? 0)) * 100
        : 0;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 150,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Bu ay toplanması gereken kutu sayısı: ${monthlyReport.hedef}',
                textStyle: context.general.textTheme.bodyMedium,
                maxLines: 2,
              ),
              20.h.ph,
              CustomText(
                'Kalan/Toplanacak Kutu Sayısı: ${monthlyReport.toplanmayan}',
                textStyle: context.general.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        30.h.ph,
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  color: context.general.colorScheme.primary,
                  value: double.tryParse(toplananYuzde.toString()),
                  title: '${toplananYuzde.toStringAsFixed(1)}%\nToplanan',
                  radius: 80,
                  titleStyle: context.general.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: context.general.colorScheme.secondary,
                  value: double.tryParse((100 - toplananYuzde).toString()),
                  title: '${(100 - toplananYuzde).toStringAsFixed(1)}%\nKalan',
                  radius: 80,
                  titleStyle: context.general.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
