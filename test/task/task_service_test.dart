import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';
import 'package:kutum_cepte_app/feature/home/service/task_service.dart';

void main() {
  late ITaskService service;
  setUp(() {
    setupLocator();
    service = TaskService();
  });
  test('Sample Test', () async {
    final response = await service.fetchCollectorTaskList(userId: 1, cityId: 1);
    log(response.toString());
  });

  /* test('Sample Test', () async {
    final response = await service.fetchDistributorTaskList(userId: 1);
    log(response.toString());
  });*/
}
