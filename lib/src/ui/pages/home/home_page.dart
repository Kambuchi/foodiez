import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_controller.dart';
import 'tabs/favorites_tab/favorites_tab.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/notifications_tab/notifications_tab.dart';
import 'tabs/profile_tab/profile_tab.dart';
import 'widgets/cart_button.dart';
import 'widgets/home_bottom_bar.dart';
import '../../global_controller/notifications_controller.dart';
import '../../../helpers/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        final controller =
            HomeController(context.read<NotificationsController>());
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          controller.afterFirstLayour();
        });
        Get.i.put<HomeController>(controller);
        controller.onDispose = () => Get.i.remove<HomeController>();
        return controller;
      },
      builder: (context, __) {
        final controller = Provider.of<HomeController>(context);
        final onProfileTab = controller.currentPage == 3;
        return Scaffold(
          floatingActionButton:
              onProfileTab ? Container() : FloatingCartButton(),
          backgroundColor: Colors.white,
          bottomNavigationBar: HomeBottomBar(),
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                HomeTab(),
                FavoriteTab(),
                NotificationsTab(),
                ProfileTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
