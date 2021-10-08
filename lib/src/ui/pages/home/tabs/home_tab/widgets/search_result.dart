import 'package:flutter/material.dart';
import '../../../../../../data/models/dish.dart';
import '../../../../../../utils/font_styles.dart';

import 'dish_item.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final List<Dish> result =  ModalRoute.of(context)!.settings.arguments as List<Dish>;
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text('Platos Encontrados',style: FontStyles.title,),
              Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
              final item = result[index];
              return DishHomeItem(
                key: UniqueKey(),
                item: item,
                isFirst: index == 0,
              );
                  },
                  itemCount: result.length,
                )),
            ],
          ),
        ));
  }
}
