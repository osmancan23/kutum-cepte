import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

enum BottomBarItemEnum {
  home(iconName: 'home', label: 'Anasayfa'),
  reports(iconName: 'report', label: 'Raporlar'),
  idCard(iconName: 'id_card', label: 'Kimlik Kartı'),
  profile(iconName: 'profile', label: 'Profil');

  const BottomBarItemEnum({required this.iconName, required this.label});

  final String iconName;
  final String label;
}

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({required this.onItemTap, super.key});
  final void Function(int) onItemTap;
  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: context.padding.normal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: BottomBarItemEnum.values.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onItemTap.call(index);
                  },
                  splashColor: Colors.transparent,
                  child: _buildNavbarItem(item, index),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbarItem(BottomBarItemEnum item, int index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            SvgPicture.asset(
              (_selectedIndex == index ? '${item.iconName}_select' : item.iconName).toSvgIc,
              height: 22.h,
            ),
            CustomText(
              item.label,
              textStyle: context.general.textTheme.bodySmall?.copyWith(
                fontSize: 10.sp,
                color: _selectedIndex == index
                    ? context.general.colorScheme.primary
                    : context.general.colorScheme.secondary,
              ),
            ),
          ],
        ),
      );
}
