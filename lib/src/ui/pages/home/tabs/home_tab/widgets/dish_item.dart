import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../dish/dish_controller.dart';
import '../../../../../global_controller/cart_controller.dart';
import '../../../../../../data/models/dish.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';

class DishHomeItem extends StatelessWidget {
  const DishHomeItem({
    Key? key,
    required this.item,
    required this.isFirst,
  }) : super(key: key);

  final Dish item;
  final bool isFirst;
  String get tag => "${this.key.toString()}-${item.id}";

  void _goToDetail(BuildContext context) {
    final int counter = context.read<CartController>().getDishCounter(this.item);

    final Dish dish =item.updateCounter(counter);
    
    Navigator.pushNamed(context, Routes.DISH,
        arguments: DishPageArguments(
          dish: dish,
          tag: this.tag,
        ));
  }

  @override
  Widget build(BuildContext context) {
  final formatter = NumberFormat('###,###', 'es_PY');
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Hero(
                tag: this.tag,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: item.photo,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.9),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        item.name,
                        style: FontStyles.regular.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Gs ",
                                style: FontStyles.regular.copyWith(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: formatter.format(item.price),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ),
                          if(item.rate == null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7)
                                .copyWith(left: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  "${item.rate}",
                                  style: FontStyles.normal.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => _goToDetail(context),
        ),
      ),
    );
  }
}
