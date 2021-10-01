class Category {
  final String iconPath, label,type;

  Category({
    required this.iconPath,
    required this.label,
    required this.type,
  }) : assert(iconPath.contains(".svg"));
}
