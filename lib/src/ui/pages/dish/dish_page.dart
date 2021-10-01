import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dish_controller.dart';
import 'widgets/dish_detail.dart';
import 'widgets/dish_header.dart';
import 'widgets/order_button.dart';
import '../home/home_controller.dart';
import '../../../helpers/get.dart';

class DishPage extends StatelessWidget {
  const DishPage({Key? key}) : super(key: key);
  void setStatusBar(bool light) {
    SystemChrome.setSystemUIOverlayStyle(
        light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DishController>(
      create: (_) {
        final homeController = Get.i.find<HomeController>();
        final DishPageArguments args =
            ModalRoute.of(context)!.settings.arguments as DishPageArguments;
        final isFavorite = homeController.isFavorite(args.dish);
        final controller = DishController(args, isFavorite);
        setStatusBar(true);
        controller.onDispose = () => setStatusBar(false);
        return controller;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: OrderButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DishHeader(),
                DishDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
