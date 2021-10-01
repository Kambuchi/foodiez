import '../models/user.dart';
import '../providers/remote/account_provider.dart';
import '../repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountProvider _provider;

  AccountRepositoryImpl(this._provider);
  
  @override
  Future<User?> get userInformation => _provider.userInformation;
}
