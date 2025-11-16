part of '../profile_view.dart';

enum _MenuTileEnum {
  users(title: 'Kullanıcılar', route: OfficersRoute()),
  changePassword(title: 'Şifre Değiştir', route: ChangePasswordRoute()),
  resetBox(title: 'Kutuları Sıfırla', route: ResetBoxesRoute()),
  shopList(title: 'Dükkan Listesi', route: ShopListRoute()),
  logout(title: 'Çıkış Yap', route: null),
  ;

  const _MenuTileEnum({required this.title, required this.route});

  final String title;
  final PageRouteInfo? route;
}

class _MenuTileWidget extends StatelessWidget {
  const _MenuTileWidget({
    required this.item,
  });
  final _MenuTileEnum item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => item.route != null ? context.router.push(item.route!) : _signOutBottomSheet(context),
      child: Container(
        width: 380.w,
        height: 72.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: context.getBoxShadow,
          borderRadius: context.border.lowBorderRadius,
        ),
        child: Padding(
          padding: context.padding.horizontalNormal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                item.title,
                textStyle: context.general.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: item == _MenuTileEnum.logout
                      ? context.general.colorScheme.error
                      : context.general.colorScheme.onPrimary,
                ),
              ),
              SvgPicture.asset((item == _MenuTileEnum.logout ? IconEnums.logout : IconEnums.arrowRight2).svgPathIcon),
            ],
          ),
        ),
      ),
    );
  }
}
