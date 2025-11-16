enum UserRoleEnum {
  admin(value: 'ROLE_ADMIN', title: 'Admin'),
  superAdmin(value: 'ROLE_SUPER_ADMIN', title: 'Süper Admin'),
  user(value: 'ROLE_USER', title: 'Kullanıcı');

  const UserRoleEnum({required this.value, required this.title});

  final String value;
  final String title;
}
