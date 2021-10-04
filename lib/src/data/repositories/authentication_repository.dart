import 'package:firebase_auth/firebase_auth.dart';
import '../responses/reset_password_response.dart';
import '../responses/sign_in_response.dart';

abstract class AutheticationRepository {
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
  Future<User?> get user;

  Future<void> signOut();
}
