import 'package:flutter_test/flutter_test.dart';

import 'package:kutum_cepte_app/core/base/service/user/user_service.dart';
import 'package:kutum_cepte_app/core/init/app/locator_service.dart';

void main() {
  late IUserService userService;
  setUp(() {
    setupLocator();
    userService = UserService();
  });
/*
  test('User Service Test', () async {
    final response = await userService.fetchAllUsers();
    expect(response, isNotEmpty);
  });*/

  test('User Service Test', () async {
    final response = await userService.fetchCurrentUser();
    expect(response, isNotNull);
  });
}
