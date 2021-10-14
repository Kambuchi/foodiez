import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiez/src/data/models/dish.dart';
import 'package:provider/provider.dart';
import '../../../global_controller/cart_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

CollectionReference users = FirebaseFirestore.instance.collection('usuarios');
final user = FirebaseAuth.instance.currentUser;

class CheckoutReview extends StatefulWidget {
  CheckoutReview({Key? key}) : super(key: key);

  @override
  State<CheckoutReview> createState() => _CheckoutReviewState();
}

class _CheckoutReviewState extends State<CheckoutReview> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CartController>();
    if (!controller.hasItems)
      return Container(
        height: 0,
      );

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 30, vertical: 15).copyWith(top: 30),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Table(
              children: [
                _buildTableRow('Subtotal', "Gs ${controller.subtotal}"),
                _buildTableRow(
                    'Impuestos y Tarifas', "Gs ${controller.taxAndFee}"),
                _buildTableRow('Delivery', "Gs ${controller.delivery}"),
                _buildTableRow('TOTAL', "Gs ${controller.total}"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: Colors.deepOrange,
                child: Text(
                  'Pedir Ahora',
                  style: FontStyles.title.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  sendRequest(controller.cart.values, user!, controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(children: [
      Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      Text(
        value,
        style: FontStyles.regular.copyWith(color: Colors.white),
        textAlign: TextAlign.right,
      ),
    ]);
  }

  void sendRequest(
    Iterable<Dish> request,
    User user,
    CartController controller,
  ) async {
    
    await users.doc('${user.uid}').set({
      'pedido': request.toString(),
      'nombre': user.displayName,
      'fecha': DateTime.now(),
    });
    for (var item in request) {
      controller.deleteFromCart(item);
    }
    final SnackBar snackBar = SnackBar(
      content: Text(
        controller.hasItems ? 'Primero agregue su pedido' : 'Pedido Realizado!',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }
}
