import '../../models/user.dart';
import '../../providers/local/authentication_client.dart';

class AccountProvider {
  final AuthenticationClient _authenticationClient;

  AccountProvider(this._authenticationClient);

  Future<User?> get userInformation async {
    final token = _authenticationClient.token;
    if (token == null) {
      throw Exception('ERROR, TOKEN INVALIDO');
    }
    Future.delayed(Duration(seconds: 2));
    return User(
        key: '1589212',
        id: "123456789",
        email: "email@example.ocm",
        name: "Kambu",
        lastname: "Chi",
        birthday: DateTime(1997, 12, 31));
  }
}
