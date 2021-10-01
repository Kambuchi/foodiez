import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/dish.dart';
import '../../../home/home_controller.dart';
import 'widgets/favorite_item.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({Key? key}) : super(key: key);

  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favorites =
        context.select<HomeController, Map<int, Dish>>((_) => _.favorites).values.toList();

    return ListView.builder(
      itemBuilder: (_, index) => FavoriteItem(
        dish: favorites[index],
      ),
      itemCount: favorites.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
