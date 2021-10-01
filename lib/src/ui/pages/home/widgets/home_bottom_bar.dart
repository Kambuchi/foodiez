import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../home_controller.dart';
import '../widgets/home_indicator.dart';
import '../../../../utils/colors.dart';

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    final int currentPage =
        context.select<HomeController, int>((_) => _.currentPage);
    final menuItems =
        context.select<HomeController, List<BottomBarItem>>((_) => _.menuItems);
    return TabBar(
      padding: EdgeInsets.only(top:10),
      controller: controller.tabController,
      indicator: HomeTabBarIndicator(),
      tabs: List.generate(
        menuItems.length,
        (index) {
          final item = menuItems[index];
          return BottomBarTab(
            item: item,
            isActive: currentPage == index,
          );
        },
      ),
    );
  }
}

class BottomBarTab extends StatelessWidget {
  const BottomBarTab({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  final BottomBarItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = this.isActive ? primaryColor : Colors.black;
    final content = Padding(
      padding: const EdgeInsets.all(5.0),
      child: SvgPicture.asset(
        item.icon,
        width: 30,
        height: 30,
        color: color,
      ),
    );
    return Tab(
        icon: item.badgeCount > 0
            ? Badge(
                badgeContent: Text(
                  "${item.badgeCount}",
                  style: TextStyle(color: Colors.white),
                ),
                child: content,
              )
            : content);
  }
}
