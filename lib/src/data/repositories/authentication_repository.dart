import '../models/user.dart';

abstract class AutheticationRepository {
  Future<String?> login(String email, String password);
  Future<bool> register(User user);
  Future<bool> sendResetToken(String email);
  Future<void> saveToken(String token);
  Future<void> signOut();
  String? get token;
}
