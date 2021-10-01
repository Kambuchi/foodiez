class Dish {
  final int id, counter;
  final String name, photo, description,type,menu;
  final int price;
  final double? rate;

  Dish({
    required this.id,
    required this.name,
    required this.type,
    required this.menu,
    required this.description,
    required this.photo,
    required this.price,
    required this.rate,
    this.counter = 0,
  });

  Dish updateCounter(int counter) {
    return Dish(
      id: this.id,
      name: this.name,
      type: this.type,
      menu: this.menu,
      description: this.description,
      photo: this.photo,
      price: this.price,
      rate: this.rate,
      counter: counter,
    );
  }
}
