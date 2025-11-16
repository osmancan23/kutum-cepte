import 'package:kutum_cepte_app/core/constants/enums/network_enums.dart';

extension NetworkExtensions on NetworkEnums {
  String get key {
    switch (this) {
      // AUTH
      case NetworkEnums.login:
        return '/public/login';

      // ADDRESSES
      case NetworkEnums.cities:
        return '/public/address/sehir';
      case NetworkEnums.districts:
        return '/public/address-ilce/';

      // TASK
      case NetworkEnums.createTaskForCollector:
        return '/admin/taskCollector-create';
      case NetworkEnums.createTaskForDistributor:
        return '/admin/taskDistributor-create';
      case NetworkEnums.collectorTaskList:
        return '/private/taskCollector-getTaskByUserId/';
      case NetworkEnums.distributorTaskList:
        return '/private/taskDistributor-getByUser/';
      case NetworkEnums.handOverCollectorTask:
        return '/private/taskCollector-assign';
      case NetworkEnums.handOverDistributorTask:
        return '/private/taskDistributor-assign';
      case NetworkEnums.updateStreetListForDistributor:
        return '/private/taskDistributor-updateSokaks/';
      case NetworkEnums.liveTracking:
        return '/admin/getAdminLiveTracking';
      case NetworkEnums.adminTaskList:
        return '/admin/getTaskList';
      case NetworkEnums.deleteDistributorTask:
        return '/admin/deleteTaskDistributorByUser/';
      case NetworkEnums.deleteCollectorTask:
        return '/admin/deleteTaskCollector';
      case NetworkEnums.finishDistributorTask:
        return '/private/task/finish-distributor-task/';
      case NetworkEnums.finishCollectorTask:
        return '/private/task/finish-collector-task/';

      // USER
      case NetworkEnums.currentUser:
        return '/public/getCurrentUser/';
      case NetworkEnums.userAll:
        return '/private/user-getAllInfo';
      case NetworkEnums.usersByCity:
        return '/private/user-getAllUserInfo';
      case NetworkEnums.userById:
        return '/private/user-getById/';
      case NetworkEnums.createUser:
        return '/private/user-create';
      case NetworkEnums.deleteUser:
        return '/private/user-delete/';
      case NetworkEnums.updateUserForAdmin:
        return '/admin/user-updateForAdmin/';
      case NetworkEnums.updateUser:
        return '/private/user-updateForUser/';
      case NetworkEnums.changePassword:
        return '/private/user-changePassword/';
      case NetworkEnums.kvkk:
        return '/public/KVKK';

      // SHOP
      case NetworkEnums.shopAll:
        return '/private/shop-getAll';
      case NetworkEnums.shopById:
        return '/private/shop-getById/';
      case NetworkEnums.createShop:
        return '/private/shop-create';
      case NetworkEnums.deleteShop:
        return '/private/shop-finishActiveShop/';
      case NetworkEnums.updateShop:
        return '/private/shop-update/';
      case NetworkEnums.changeShopNo:
        return '/private/shop-changeShopNo';

      // SHOP HISTORY
      case NetworkEnums.createShopHistory:
        return '/private/shopHistory-create';
      case NetworkEnums.shopHistoryAll:
        return '/private/shopHistory-getAll';
      case NetworkEnums.shopHistoryById:
        return '/private/shopHistory-getAllByShop/';

      // REPORT
      case NetworkEnums.reportForAdmin:
        return '/admin/getAllReport';
      case NetworkEnums.reportForWorker:
        return '/user/getReportByUser/';
      case NetworkEnums.resetShop:
        return '/admin/resetShops/';
      case NetworkEnums.dailyReportForCollector:
        return '/admin/report-by-type/collector';
      case NetworkEnums.dailyReportForDistributor:
        return '/admin/report-by-type/distributor';
      case NetworkEnums.monthlyReport:
        return '/admin/reports/monthly-report';
      case NetworkEnums.weeklyReport:
        return '/admin/reports/users';
    }
  }
}
