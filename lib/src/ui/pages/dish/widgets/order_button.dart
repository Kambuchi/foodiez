import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../global_controller/cart_controller.dart';
import '../../../global_widgets/rounded_button.dart';

import '../dish_controller.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({Key? key}) : super(key: key);

  void _addToCart(BuildContext context) {
    final cartController = context.read<CartController>();

    final controller = context.read<DishController>();
    final isNotEmpty = controller.dish.counter > 0;

    final isInCart = cartController.isInCart(controller.dish);
    if(isNotEmpty){
    cartController.addToCart(controller.dish);
    final SnackBar snackBar = SnackBar(
      content: Text(
        isInCart ? 'Orden actualizada!' : 'Agregado al carrito',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      final SnackBar snackBar = SnackBar(
      content: Text(
        'Agrega por lo menos un elemento',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dishController = Provider.of<DishController>(context, listen: false);
    final bool isInCart = context
        .select<CartController, bool>((_) => _.isInCart(dishController.dish));
    return RoundedButton(
      label: isInCart ? 'Actualizar Orden' : 'Agregar al Carrito',
      fullWidth: false,
      fontSize: 20,
      onPressed: () => _addToCart(context),
    );
  }
}
