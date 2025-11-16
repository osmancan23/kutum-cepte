part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class AdminReportListLoading extends ReportState {}

final class AdminReportListCompleted extends ReportState {
  AdminReportListCompleted(this.adminReportList);
  final List<AdminReportListModel> adminReportList;
}

final class AdminReportListError extends ReportState {
  AdminReportListError(this.message);
  final String message;
}

final class WorkerReportListLoading extends ReportState {}

final class WorkerReportListCompleted extends ReportState {
  WorkerReportListCompleted(this.workerReport);
  final WorkerReportModel workerReport;
}

final class WorkerReportListError extends ReportState {
  WorkerReportListError(this.message);
  final String message;
}

final class DistributorDailyReportListLoading extends ReportState {}

final class DistributorDailyReportListCompleted extends ReportState {
  DistributorDailyReportListCompleted(this.dailyReportList);
  final List<DailyReportModel> dailyReportList;
}

final class DistributorDailyReportListError extends ReportState {
  DistributorDailyReportListError(this.message);
  final String message;
}

final class CollectorDailyReportListLoading extends ReportState {}

final class CollectorDailyReportListCompleted extends ReportState {
  CollectorDailyReportListCompleted(this.dailyReportList);
  final List<DailyReportModel> dailyReportList;
}

final class CollectorDailyReportListError extends ReportState {
  CollectorDailyReportListError(this.message);
  final String message;
}

final class MonthlyReportLoading extends ReportState {}

final class MonthlyReportCompleted extends ReportState {
  MonthlyReportCompleted(this.monthlyReport);
  final MonthlyReportResponseModel monthlyReport;
}

final class MonthlyReportError extends ReportState {
  MonthlyReportError(this.message);
  final String message;
}

final class WeeklyReportListLoading extends ReportState {}

final class WeeklyReportListCompleted extends ReportState {
  WeeklyReportListCompleted(this.weeklyReport);
  final List<WeeklyReportModel> weeklyReport;
}

final class WeeklyReportListError extends ReportState {
  WeeklyReportListError(this.message);
  final String message;
}
