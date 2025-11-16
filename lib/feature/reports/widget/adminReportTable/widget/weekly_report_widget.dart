part of '../../../reports_view.dart';

class _WeeklyReportWidget extends StatefulWidget {
  @override
  State<_WeeklyReportWidget> createState() => _WeeklyReportWidgetState();
}

class _WeeklyReportWidgetState extends State<_WeeklyReportWidget> {
  late ReportBloc _reportBloc;

  @override
  void initState() {
    super.initState();
    _reportBloc = ReportBloc(ReportService());

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    _reportBloc.add(
      FetchWeeklyReportList(
        DateTime(2024),
        endOfWeek,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.general.mediaQuery.size.height * 0.6,
          child: BlocBuilder<ReportBloc, ReportState>(
            bloc: _reportBloc,
            builder: (context, state) {
              if (state is WeeklyReportListCompleted) {
                // Kullanıcıları gruplandır
                final userReports = <int, List<WeeklyReportModel>>{};
                for (final report in state.weeklyReport) {
                  if (!userReports.containsKey(report.userId)) {
                    userReports[report.userId!] = [];
                  }
                  userReports[report.userId!]!.add(report);
                }

                return userReports.isNotEmpty
                    ? ListView.builder(
                        itemCount: userReports.length,
                        itemBuilder: (context, index) {
                          final userId = userReports.keys.elementAt(index);
                          final userReportsList = userReports[userId]!;

                          // Haftanın her günü için çalışma durumunu kontrol et
                          final workDays = <int, bool>{};
                          for (var i = 1; i <= 7; i++) {
                            // Pazartesi'den Pazar'a
                            workDays[i] = userReportsList.any((report) {
                              final reportDate = DateTime.parse(report.createDate!);
                              return reportDate.weekday == i;
                            });
                          }

                          return _WeeklyReportItemWidget(
                            userId: userId,
                            userName: userReportsList.first.name ?? '',
                            userSurname: userReportsList.first.surname ?? '',
                            workDays: workDays,
                            photoUrl: userReportsList.first.photoUrl,
                          );
                        },
                      )
                    : const CustomText('Henüz rapor yok');
              } else if (state is WeeklyReportListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeeklyReportListError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _WeeklyReportItemWidget extends StatelessWidget {
  const _WeeklyReportItemWidget({
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.workDays,
    this.photoUrl,
  });

  final int userId;
  final String userName;
  final String userSurname;
  final Map<int, bool> workDays;
  final String? photoUrl;
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
              child: photoUrl != null
                  ? CacheNetworkImageWidget(imageUrl: photoUrl!)
                  : Image.asset(
                      ImageEnums.logo.pngPath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      '$userName $userSurname',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDayColumn('Pzt', workDays[1] ?? false),
                      _buildDayColumn('Salı', workDays[2] ?? false),
                      _buildDayColumn('Çrş', workDays[3] ?? false),
                      _buildDayColumn('Prş', workDays[4] ?? false),
                      _buildDayColumn('Cuma', workDays[5] ?? false),
                      _buildDayColumn('Cmt', workDays[6] ?? false),
                      _buildDayColumn('Paz', workDays[7] ?? false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayColumn(String day, bool isWorked) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          CustomText(
            day,
            textStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          CustomText(isWorked ? '✅' : '❌'),
        ],
      ),
    );
  }
}
