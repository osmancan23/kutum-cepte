part of '../../reports_view.dart';

class _AdminReportTableWidget extends StatefulWidget {
  const _AdminReportTableWidget();

  @override
  State<_AdminReportTableWidget> createState() => _AdminReportTableWidgetState();
}

class _AdminReportTableWidgetState extends State<_AdminReportTableWidget> {
  final List<String> _tabList = ['🔺 Canlı', 'Günlük', 'Haftalık', 'Aylık'];

  String selectedRole = 'Toplayıcı';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: Column(
        children: [
          TabBar(
            tabs: _tabList.map((e) => Tab(text: e)).toList(),
            labelColor: context.general.colorScheme.primary,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelStyle: context.general.textTheme.bodyLarge?.copyWith(
              fontSize: 16.sp,
            ),
            unselectedLabelStyle: context.general.textTheme.bodyLarge?.copyWith(
              color: context.general.colorScheme.secondary,
              fontSize: 16.sp,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              children: [
                const _LiveReportWidget(),
                const _DailyReportWidget(),
                _WeeklyReportWidget(),
                const _MonthlyReportWidget(),
                /* const _YearlyReportWidget(),
                _OtherReportWidget(),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
