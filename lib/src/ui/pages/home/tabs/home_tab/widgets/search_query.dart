import 'package:flutter/material.dart';
import '../../../../../../data/models/dish.dart';
import 'dish_item.dart';

class SearchQuery extends StatefulWidget {
  @override
  State<SearchQuery> createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQuery> {
  late List<Dish> menu;
  late List<Dish> allMenu;
  String query = '';

  @override
  void initState() {
    super.initState();
    menu = [];
  }

  @override
  Widget build(BuildContext context) {
    allMenu = ModalRoute.of(context)!.settings.arguments as List<Dish>;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SearchWidget(
                text: query,
                onChanged: searchDish,
                hintText: 'Encuentra tu comida preferida!'),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              final item = menu[index];
              return DishHomeItem(
                key: UniqueKey(),
                item: item,
                isFirst: false,
              );
            },
            itemCount: menu.length,
          )),
        ],
      ),
    ));
  }

  void searchDish(String query) {
    final result = allMenu.where((dish) {
      final nameLower = dish.name.toLowerCase();
      final typeLower = dish.type.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) || typeLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.menu = result;
    });
  }
}

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
