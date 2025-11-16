enum NetworkEnums {
  //AUTH
  login,

  //ADDRESS
  cities,
  districts,

  //TASK
  createTaskForCollector,
  createTaskForDistributor,
  collectorTaskList,
  distributorTaskList,
  handOverCollectorTask,
  handOverDistributorTask,
  updateStreetListForDistributor,
  liveTracking,
  adminTaskList,
  deleteDistributorTask,
  deleteCollectorTask,
  finishDistributorTask,
  finishCollectorTask,

  //USER
  currentUser,
  userAll,
  usersByCity,
  userById,
  createUser,
  deleteUser,
  updateUserForAdmin,
  updateUser,
  changePassword,
  kvkk,

  //SHOP
  shopAll,
  shopById,
  createShop,
  deleteShop,
  updateShop,
  changeShopNo,
  resetShop,

  //SHOP HISTORY
  createShopHistory,
  shopHistoryAll,
  shopHistoryById,

  //REPORT
  reportForAdmin,
  reportForWorker,
  dailyReportForCollector,
  dailyReportForDistributor,
  monthlyReport,
  weeklyReport,
}
