class OnboardItem {
  final String image, title, description;

  OnboardItem({
    required this.title,
    required this.image,
    required this.description,
  })  : assert(image.contains('.svg'));
}
