import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/core/constants/enums/report_type_enum.dart';
import 'package:kutum_cepte_app/feature/reports/model/admin_report_list_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/daily_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/monthly_report_response_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/weekly_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/worker_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/service/report_service.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(this._reportService) : super(ReportInitial()) {
    on<FetchAdminReportList>(_fetchAdminReportList);
    on<FetchWorkerReportList>(_fetchWorkerReportList);
    on<FetchDistributorDailyReportList>(_fetchDistributorDailyReportList);
    on<FetchCollectorDailyReportList>(_fetchCollectorDailyReportList);
    on<FetchMonthlyReport>(_fetchMonthlyReport);
    on<FetchWeeklyReportList>(_fetchWeeklyReportList);
  }
  final IReportService _reportService;

  Future<void> _fetchAdminReportList(FetchAdminReportList event, Emitter<ReportState> emit) async {
    try {
      emit(AdminReportListLoading());
      final response = await _reportService.fetchAdminReportList(cityId: event.cityId);
      emit(AdminReportListCompleted(response));
    } catch (e) {
      emit(AdminReportListError('Bir hata oluştu'));
    }
  }

  Future<void> _fetchWorkerReportList(FetchWorkerReportList event, Emitter<ReportState> emit) async {
    try {
      emit(WorkerReportListLoading());
      final response = await _reportService.fetchWorkerReportList(userId: event.userId, date: event.date);
      response != null ? emit(WorkerReportListCompleted(response)) : emit(WorkerReportListError('Bir hata oluştu'));
    } catch (e) {
      emit(WorkerReportListError('Bir hata oluştu'));
    }
  }

  Future<void> _fetchDistributorDailyReportList(
    FetchDistributorDailyReportList event,
    Emitter<ReportState> emit,
  ) async {
    try {
      emit(DistributorDailyReportListLoading());
      final response = await _reportService.fetchReportListForDistributor(
        reportType: event.reportType,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(DistributorDailyReportListCompleted(response));
    } catch (e) {
      emit(DistributorDailyReportListError('Bir hata oluştu'));
    }
  }

  Future<void> _fetchCollectorDailyReportList(FetchCollectorDailyReportList event, Emitter<ReportState> emit) async {
    try {
      emit(CollectorDailyReportListLoading());
      final response = await _reportService.fetchReportListForCollector(
        reportType: event.reportType,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(CollectorDailyReportListCompleted(response));
    } catch (e) {
      emit(CollectorDailyReportListError('Bir hata oluştu'));
    }
  }

  Future<void> _fetchMonthlyReport(FetchMonthlyReport event, Emitter<ReportState> emit) async {
    try {
      emit(MonthlyReportLoading());
      final response = await _reportService.fetchMonthlyReport(
        cityId: event.cityId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(MonthlyReportCompleted(response!));
    } catch (e) {
      emit(MonthlyReportError('Bir hata oluştu'));
    }
  }

  Future<void> _fetchWeeklyReportList(FetchWeeklyReportList event, Emitter<ReportState> emit) async {
    try {
      emit(WeeklyReportListLoading());
      final response = await _reportService.fetchWeeklyReportList(
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(WeeklyReportListCompleted(response));
    } catch (e) {
      emit(WeeklyReportListError('Bir hata oluştu'));
    }
  }
}
