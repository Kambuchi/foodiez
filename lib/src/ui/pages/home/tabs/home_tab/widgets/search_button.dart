
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodiez/src/data/models/dish.dart';
import 'package:foodiez/src/helpers/get.dart';
import 'package:foodiez/src/routes/routes.dart';
import '../../../../../../utils/font_styles.dart';

class SearchButton extends StatelessWidget {
  final List<Dish> menu;
   SearchButton({
    required List<Dish> this.menu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Colors.black38,
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/pages/home/search.svg',
              width: 20,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text('Encuentra tu comida preferida...',style: FontStyles.regular.copyWith(color: Colors.white),)
          ],
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.SEARCH_QUERY,
                        arguments: this.menu);
        });
  }
}

