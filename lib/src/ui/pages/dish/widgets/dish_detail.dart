import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../dish_controller.dart';
import '../../home/home_controller.dart';
import '../../../global_widgets/dish_counter.dart';
import '../../../../helpers/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class DishDetail extends StatelessWidget {
  const DishDetail({Key? key}) : super(key: key);

  void _toggleFavorite(BuildContext context) {
    final homeController = Get.i.find<HomeController>();
    final controller = context.read<DishController>();
    if (!controller.isFavorite) {
      final SnackBar snackBar = SnackBar(
        content: Text(
          'Added to favorites',
          textAlign: TextAlign.center,
        ),
        backgroundColor: primaryColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    controller.toString();
    homeController.toggleFavorite(controller.dish);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DishController>(context);
    final dish = controller.dish;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: FontStyles.title,
                    ),
                    Text(
                      "\$ ${dish.price}",
                      style: FontStyles.title,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/pages/home/favorite.svg',
                  width: 35,
                  height: 35,
                  color: controller.isFavorite ? primaryColor : Colors.grey,
                ),
                onPressed: () => _toggleFavorite(context),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          DishCounter(
            initialValue: controller.dish.counter,
            onChanged: controller.onCounterChanged,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            dish.description,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
