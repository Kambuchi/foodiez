import 'package:flutter/material.dart';
import '../../../../../data/models/dish.dart';
import '../../../../../data/models/category.dart';
import '../../../../../data/repositories/food_menu_repository.dart';
import '../../../../../helpers/get.dart';

class HomeTabController extends ChangeNotifier {
  final FoodMenuRepository _foodMenuRepository =
      Get.i.find<FoodMenuRepository>();
  final List<Category> categories = [
    Category(
      iconPath: 'assets/pages/home/home_tab/breakfast.svg',
      label: 'Almuerzo',
      type: 'almuerzo',
    ),
    Category(
      iconPath: 'assets/pages/home/home_tab/fries.svg',
      label: 'Comida Rápida',
      type: 'rapida',
    ),
    Category(
      iconPath: 'assets/pages/home/home_tab/dinner.svg',
      label: 'Cena',
      type: 'cena',
    ),
    Category(
      iconPath: 'assets/pages/home/home_tab/dessert.svg',
      label: 'Postres',
      type: 'postre',
    ),
  ];

  List<Dish> _popularMenu = [];
  List<Dish> get popularMenu => _popularMenu;


  void afterFirstLayour() {
    _init();
  }

  void _init() async {
    _popularMenu = await _foodMenuRepository.getPopularMenu();
    notifyListeners();
  }
}
