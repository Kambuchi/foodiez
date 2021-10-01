import 'package:flutter/material.dart';
import '../../../data/models/dish.dart';

class DishPageArguments {
  final Dish dish;
  final String tag;

  DishPageArguments({
    required this.dish,
    required this.tag,
  });
}

class DishController extends ChangeNotifier {
  Dish dish;
  VoidCallback? onDispose;
  final String tag;

  DishController(DishPageArguments arguments, this._isFavorite)
      : this.dish = arguments.dish,
        this.tag = arguments.tag;

  bool _isFavorite;
  bool get isFavorite => _isFavorite;

  void onCounterChanged(int counter) {
    this.dish = this.dish.updateCounter(counter);
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  @override
  void dispose() {
    if (onDispose != null) {
      onDispose!();
    }
    super.dispose();
  }
}
