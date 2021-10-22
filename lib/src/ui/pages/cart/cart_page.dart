import 'package:flutter/material.dart';
import 'package:foodiez/src/utils/colors.dart';
import 'package:provider/provider.dart';
import 'widgets/cart_item.dart';
import '../../global_controller/cart_controller.dart';
import '../../pages/cart/widgets/checkout_review.dart';
import '../../../utils/font_styles.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>().cart.values.toList();
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text('Mi carrito',style: TextStyle(color:Colors.white),),
        backgroundColor: primaryColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded)),
        elevation: 0,
      ),
      body: SafeArea(
        child: cart.length == 0
            ? Center(
                child: Text(
                  "No hay elementos",
                  style: FontStyles.regular,
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) {
                  final dish = cart[index];
                  return CartItem(dish: dish);
                },
                itemCount: cart.length,
              ),
      ),
      bottomNavigationBar: CheckoutReview(),
    );
  }
}
