import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiez/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'home_tab_controller.dart';
import 'widgets/horizontal_dishes.dart';
import 'widgets/categories_menu.dart';
import 'widgets/search_button.dart';
import '../../../../../data/models/dish.dart';
import '../../../../../utils/font_styles.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomeTabController>(
      create: (_) {
        final controller = HomeTabController();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          controller.afterFirstLayour();
        });
        return controller;
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hola, Kambu'),
                    Text(
                      'Pide tu comida, quedate en casa',
                      style: FontStyles.title.copyWith(fontSize: 22),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SearchButton(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              CategoriesMenu(),
              SizedBox(height: 20),
              Builder(builder: (context) {
                final List<Dish> popularMenu =
                    context.select<HomeTabController, List<Dish>>(
                  (_) => _.popularMenu.where((e) => e.menu == 'popular').toList(),
                );
                return HorizontalDishes(
                  dishes: popularMenu,
                  title: "Menu Popular",
                  onViewAll: () {
                   Navigator.pushNamed(context, Routes.SEARCH_RESULT, arguments: popularMenu);
                  },
                );
              }), 
              SizedBox(height: 20),
              Builder(builder: (context) {
                final List<Dish> offerMenu =
                    context.select<HomeTabController, List<Dish>>(
                  (_) => _.popularMenu.where((e) => e.menu == 'offer').toList(),
                );
                return HorizontalDishes(
                  dishes: offerMenu,
                  title: "Ofertas de Hoy",
                  onViewAll: () {
                   Navigator.pushNamed(context, Routes.SEARCH_RESULT, arguments: offerMenu);

                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
