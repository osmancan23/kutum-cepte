import 'package:kutum_cepte_app/core/base/model/base_response_list_model.dart';
import 'package:kutum_cepte_app/core/base/model/base_response_model.dart';
import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';
import 'package:kutum_cepte_app/core/constants/enums/report_type_enum.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/core/init/network/vexana_manager.dart';
import 'package:kutum_cepte_app/feature/reports/model/admin_report_list_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/daily_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/monthly_report_response_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/weekly_report_model.dart';
import 'package:kutum_cepte_app/feature/reports/model/worker_report_model.dart';
import 'package:kutum_cepte_app/utils/extension/date_time_extensions.dart';
import 'package:kutum_cepte_app/utils/extension/network_extensions.dart';
import 'package:vexana/vexana.dart';

abstract class IReportService {
  IReportService() : _networkManager = locator<VexanaManager>();

  final VexanaManager _networkManager;

  Future<List<AdminReportListModel>> fetchAdminReportList({required int cityId});
  Future<WorkerReportModel?> fetchWorkerReportList({required int userId, required String date});

  Future<List<DailyReportModel>> fetchReportListForDistributor({
    required ReportTypeEnum reportType,
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<List<DailyReportModel>> fetchReportListForCollector({
    required ReportTypeEnum reportType,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<MonthlyReportResponseModel?> fetchMonthlyReport({
    required int cityId,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<List<WeeklyReportModel>> fetchWeeklyReportList({
    required DateTime startDate,
    required DateTime endDate,
  });
}

class ReportService extends IReportService {
  @override
  Future<List<AdminReportListModel>> fetchAdminReportList({required int cityId}) async {
    final response = await _networkManager
        .send<BaseResponseListModel<AdminReportListModel>, BaseResponseListModel<AdminReportListModel>>(
      NetworkEnums.reportForAdmin.key,
      parseModel: const BaseResponseListModel(parseModel: AdminReportListModel()),
      method: RequestType.GET,
      queryParameters: {'sehirId': cityId},
    );
    return response.data?.data ?? [];
  }

  @override
  Future<WorkerReportModel?> fetchWorkerReportList({required int userId, required String date}) async {
    final response =
        await _networkManager.send<BaseResponseModel<WorkerReportModel>, BaseResponseModel<WorkerReportModel>>(
      '${NetworkEnums.reportForWorker.key}/$userId',
      parseModel: const BaseResponseModel(parseModel: WorkerReportModel()),
      method: RequestType.GET,
      queryParameters: {'date': date},
    );
    return response.data?.data;
  }

  @override
  Future<List<DailyReportModel>> fetchReportListForCollector({
    required ReportTypeEnum reportType,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response =
        await _networkManager.send<BaseResponseListModel<DailyReportModel>, BaseResponseListModel<DailyReportModel>>(
      NetworkEnums.dailyReportForCollector.key,
      parseModel: BaseResponseListModel(parseModel: DailyReportModel()),
      method: RequestType.POST,
      data: {'reportType': reportType.value, 'startDate': startDate.formattedDate, 'endDate': endDate.formattedDate},
    );
    return response.data?.data ?? [];
  }

  @override
  Future<List<DailyReportModel>> fetchReportListForDistributor({
    required ReportTypeEnum reportType,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response =
        await _networkManager.send<BaseResponseListModel<DailyReportModel>, BaseResponseListModel<DailyReportModel>>(
      NetworkEnums.dailyReportForDistributor.key,
      parseModel: BaseResponseListModel(parseModel: DailyReportModel()),
      method: RequestType.POST,
      data: {'reportType': reportType.value, 'startDate': startDate.formattedDate, 'endDate': endDate.formattedDate},
    );
    return response.data?.data ?? [];
  }

  @override
  Future<MonthlyReportResponseModel?> fetchMonthlyReport({
    required int cityId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _networkManager
        .send<BaseResponseModel<MonthlyReportResponseModel>, BaseResponseModel<MonthlyReportResponseModel>>(
      NetworkEnums.monthlyReport.key,
      parseModel: BaseResponseModel(parseModel: MonthlyReportResponseModel()),
      method: RequestType.POST,
      data: {
        'sehirId': cityId,
        'startDate': startDate.formattedDate,
        'endDate': endDate.formattedDate,
      },
    );

    return response.data?.data;
  }

  @override
  Future<List<WeeklyReportModel>> fetchWeeklyReportList({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response =
        await _networkManager.send<BaseResponseListModel<WeeklyReportModel>, BaseResponseListModel<WeeklyReportModel>>(
      NetworkEnums.weeklyReport.key,
      parseModel: BaseResponseListModel(parseModel: WeeklyReportModel()),
      method: RequestType.POST,
      data: {
        'startDate': startDate.formattedDate,
        'endDate': endDate.formattedDate,
      },
    );

    return response.data?.data ?? [];
  }
}
