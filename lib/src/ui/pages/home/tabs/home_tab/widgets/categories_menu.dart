import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodiez/src/data/models/dish.dart';
import 'package:foodiez/src/routes/routes.dart';
import 'package:provider/provider.dart';
import '../home_tab_controller.dart';
import '../../../../../../data/models/category.dart';
import '../../../../../../utils/font_styles.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeTabController>(context, listen: false);
    return Container(
      height: 140,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(controller.categories.length, (index) {
          final category = controller.categories[index];
          return CategoryButton(
            category: category,
            isFirst: index == 0,
          );
        }),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.category,
    required this.isFirst,
  }) : super(key: key);

  final Category category;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final List<Dish> categoryMenu =
        context.select<HomeTabController, List<Dish>>(
      (_) => _.popularMenu.where((e) => e.type == category.type).toList(),
    );
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: isFirst ? 17 : 5,
        bottom: 10,
        right: 5,
      ),
      child: CupertinoButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              children: [
                Expanded(
                    child: SvgPicture.asset(
                  category.iconPath,
                  width: 80,
                )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  category.label,
                  style: FontStyles.regular.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.SEARCH_RESULT,
                arguments: categoryMenu);
          }),
    );
  }
}
