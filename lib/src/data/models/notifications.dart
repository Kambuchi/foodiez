class AppNotification {
  final int id;
  final String title, description;
  final dynamic content;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.createdAt,
  });
}
