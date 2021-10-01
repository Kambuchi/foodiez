import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../global_controller/cart_controller.dart';
import '../../../../data/models/dish.dart';
import '../../../../routes/routes.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasItems = context.select<CartController, bool>((_) => _.hasItems);

    if (!hasItems) return Container();
    final cart = context.select<CartController, Map<int, Dish>>((_) => _.cart);
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        FloatingActionButton(
          child: SvgPicture.asset(
            'assets/pages/home/cart.svg',
            width: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.CART);
          },
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration:
                BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              "${cart.length}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
