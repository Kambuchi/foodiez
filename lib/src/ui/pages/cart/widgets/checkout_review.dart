import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../global_controller/cart_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class CheckoutReview extends StatelessWidget {
  const CheckoutReview({Key? key}) : super(key: key);

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
                _buildTableRow('Subtotal', "\$ ${controller.subtotal}"),
                _buildTableRow('Impuestos y Tarifas', "\$ ${controller.taxAndFee}"),
                _buildTableRow('Delivery', "\$ ${controller.delivery}"),
                _buildTableRow('TOTAL', "\$ ${controller.subtotal}"),
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
                onPressed: () {},
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
}
