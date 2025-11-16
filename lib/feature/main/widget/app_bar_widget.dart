part of '../view/main_view.dart';

class _AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppbarWidget();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: locator<MainViewModel>().selectedIndex,
      builder: (context, value, child) {
        switch (value) {
          case 0:
            return const _HomeViewAppbarWidget();
          case 3:
            return const AppbarWidget(
              title: 'Profilim Menüsü',
            );
          default:
            return const _IdentityCardAppbarWidget();
        }
      },
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 190.h);
}
