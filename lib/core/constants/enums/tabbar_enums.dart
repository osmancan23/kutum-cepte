import 'package:flutter/material.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/liveTracking/view/live_tracking_view.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskAssignment/view/task_assignment_view.dart';
import 'package:kutum_cepte_app/feature/home/view/admin/taskList/view/task_list_view.dart';
import 'package:kutum_cepte_app/feature/home/view/officer/collectionTaskList/collection_task_list_view.dart';
import 'package:kutum_cepte_app/feature/home/view/officer/distributorTaskList/distributor_task_list_view.dart';

enum TabbarType {
  admin(
    items: [
      TabbarItemEnum.taskAssignment,
      TabbarItemEnum.taskList,
      TabbarItemEnum.liveTracking,
    ],
  ),
  user(
    items: [
      TabbarItemEnum.collectionTaskList,
      TabbarItemEnum.deliveryTaskList,
    ],
  ),
  ;

  const TabbarType({required this.items});

  final List<TabbarItemEnum> items;
}

enum TabbarItemEnum {
  // Admin Tabbar Items
  taskAssignment(title: 'Görev Atama', body: TaskAssignmentView()),
  taskList(title: 'Görev Listesi', body: TaskListView()),
  liveTracking(title: 'Canlı Takip', body: LiveTrackingView()),

  // User Tabbar Items
  collectionTaskList(title: 'Toplayıcı Görev Listesi', body: CollectionTaskListView()),
  deliveryTaskList(title: 'Dağıtıcı Görev Listesi', body: DistributorTaskListView()),
  ;

  const TabbarItemEnum({required this.title, required this.body});

  final String title;
  final Widget body;
}
