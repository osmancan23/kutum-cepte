import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

import 'package:kutum_cepte_app/core/components/text/custom_text.dart';
import 'package:kutum_cepte_app/core/constants/enums/tabbar_enums.dart';

class TabbarWidget extends StatefulWidget implements PreferredSizeWidget {
  const TabbarWidget({
    required this.onChange, 
    required this.type, 
    this.firstItem,
    super.key
  });
  final void Function(TabbarItemEnum item) onChange;
  final TabbarItemEnum? firstItem;
  final TabbarType type;
  @override
  State<TabbarWidget> createState() => _AchievementTabbarState();

  @override
  Size get preferredSize => Size.fromHeight(290.h);
}

class _AchievementTabbarState extends State<TabbarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TabbarItemEnum _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.firstItem ?? widget.type.items.first;
    final initialIndex = widget.type.items.indexOf(_selectedItem);
    _tabController = TabController(
      vsync: this, 
      length: widget.type.items.length,
      initialIndex: initialIndex,
    );
    
    // Build işlemi tamamlandıktan sonra çağrılacak
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChange.call(_selectedItem);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            
            onTap: (index) {
              _selectedItem = widget.type.items[index];
              widget.onChange.call(_selectedItem);
              setState(() {});
            },
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            controller: _tabController,
            dividerColor: Colors.transparent,
            tabs: widget.type.items.map((e) => _tabItemWidget(context, tab: e)).toList(),
          ),
        ],
      ),
    );
  }

  Tab _tabItemWidget(BuildContext context, {required TabbarItemEnum tab}) {
    return Tab(
      child: CustomText(
        tab.title,
        textStyle: context.general.textTheme.bodyLarge?.copyWith(
          color: _selectedItem == tab ? context.general.colorScheme.primary : context.general.colorScheme.secondary,
          fontSize: 16.sp,
        ),
        maxLines: 1,
      ),
    );
  }
}
