import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../global_controller/cart_controller.dart';
import '../../../global_widgets/dish_counter.dart';
import '../../../../data/models/dish.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class CartItem extends StatelessWidget {
  final Dish dish;
  const CartItem({Key? key, required this.dish}) : super(key: key);

  void _deleteItem(BuildContext context) {
    final cartController = context.read<CartController>();
    cartController.deleteFromCart(dish);
  }

  void _onCounterChanged(BuildContext context, int counter) {
    final updatedDish = dish.updateCounter(counter);
    final cartController = context.read<CartController>();
    cartController.addToCart(updatedDish, updated: false);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 5),
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _deleteItem(context),
          ),
        ),
      ],
      child: Container(
        margin: const EdgeInsets.all(10).copyWith(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: dish.photo,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
              flex: 2,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: FontStyles.regular,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${dish.price}",
                        style: FontStyles.title.copyWith(color: primaryColor),
                      ),
                      DishCounter(
                        size: DishCounterSize.mini,
                        initialValue: dish.counter,
                        onChanged: (counter) =>
                            _onCounterChanged(context, counter),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
