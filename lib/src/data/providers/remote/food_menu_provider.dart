import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/dish.dart';

class FoodMenuProvider {
  Future<List<Dish>> getPopularProvider() async {
    final jsonAsString = await rootBundle
        .loadString('assets/pages/home/home_tab/json/popular_menu.json');
    final List list = jsonDecode(jsonAsString);
    List<Dish> dishes = [];
    for (final Map<String, dynamic> item in list) {
      final dish = Dish(
          id: item['id'],
          name: item['name'],
          photo: item['preview'],
          price: item['price'],
          type: item['type'],
          menu: item['menu'],
          rate: item['rate'] != null
              ? double.parse(
                  item['rate'].toString(),
                )
              : null,
          description: item['description']);

      dishes.add(dish);
    }
    return dishes;
  }
}
