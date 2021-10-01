class User {
  final String id, email, name, lastname;
  final String? key;
  final DateTime birthday;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.birthday, 
    this.key
  }) : assert(email.contains("@"));
}
