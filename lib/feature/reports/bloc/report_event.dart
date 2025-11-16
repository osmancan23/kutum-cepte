part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class FetchAdminReportList extends ReportEvent {
  FetchAdminReportList({required this.cityId});

  final int cityId;
}

final class FetchWorkerReportList extends ReportEvent {
  FetchWorkerReportList(this.userId, this.date);
  final int userId;
  final String date;
}

final class FetchDistributorDailyReportList extends ReportEvent {
  FetchDistributorDailyReportList(this.reportType, this.startDate, this.endDate);
  final ReportTypeEnum reportType;
  final DateTime startDate;
  final DateTime endDate;
}

final class FetchCollectorDailyReportList extends ReportEvent {
  FetchCollectorDailyReportList(this.reportType, this.startDate, this.endDate);
  final ReportTypeEnum reportType;
  final DateTime startDate;
  final DateTime endDate;
}

final class FetchMonthlyReport extends ReportEvent {
  FetchMonthlyReport(this.cityId, this.startDate, this.endDate);
  final int cityId;
  final DateTime startDate;
  final DateTime endDate;
}

final class FetchWeeklyReportList extends ReportEvent {
  FetchWeeklyReportList(this.startDate, this.endDate);
  final DateTime startDate;
  final DateTime endDate;
}
