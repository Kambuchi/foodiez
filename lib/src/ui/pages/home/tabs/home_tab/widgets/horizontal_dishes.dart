import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dish_item.dart';
import '../../../../../../data/models/dish.dart';
import '../../../../../../utils/font_styles.dart';

class HorizontalDishes extends StatelessWidget {
  final List<Dish> dishes;
  final String title;
  final VoidCallback? onViewAll;

  const HorizontalDishes({
    Key? key,
    required this.dishes,
    required this.title,
    this.onViewAll,
  })  : 
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: FontStyles.title,
                ),
                CupertinoButton(
                  padding: EdgeInsets.all(10),
                  minSize: 25,
                  child: Text(
                    'Ver Todos',
                    style: FontStyles.regular,
                  ),
                  onPressed: this.onViewAll,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 5),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                if(index< 4){
                final item = dishes[index];
                return DishHomeItem(
                  key: UniqueKey(),
                  item: item,
                  isFirst: index == 0,
                );

                }
                return Container();
              },
              itemCount: dishes.length,
            ),
          ),
        ],
      ),
    );
  }
}
