import 'package:flutter/widgets.dart';
import '../../data/models/dish.dart';

class CartController extends ChangeNotifier {
  Map<int, Dish> _cart = {};
  Map<int, Dish> get cart => _cart;

  bool isInCart(Dish dish) {
    return _cart.containsKey(dish.id);
  }

  bool get hasItems => _cart.length > 0;

  int get subtotal => int.parse(cart.values
      .map((e) => e.price * e.counter)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(0));

  int get taxAndFee =>
      int.parse((subtotal * 0.1 + subtotal * 0.05).toStringAsFixed(0));
  int get delivery => 5000;
  int get total =>
      int.parse((subtotal + taxAndFee + delivery).toStringAsFixed(0));

  int getDishCounter(Dish dish) {
    if (isInCart(dish)) {
      return _cart[dish.id]!.counter;
    }
    return 0;
  }

  void addToCart(Dish dish, {bool updated = true}) {
    Map<int, Dish> copy = Map<int, Dish>.from(_cart);
    copy[dish.id] = dish;
    _cart = copy;
    if (updated) {
      notifyListeners();
    }
  }

  void deleteFromCart(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_cart);
    if (copy.containsKey(dish.id)) {
      copy.remove(dish.id);
      _cart = copy;
      notifyListeners();
    }
  }
}
