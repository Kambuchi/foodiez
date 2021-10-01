import '../providers/local/preferences_provider.dart';
import '../repositories/preferences_reposiory.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {

  final PreferencesProvider _provider;  
  PreferencesRepositoryImpl(this._provider);
  @override
  bool get OnboardAndWelcomeReady => _provider.OnboardAndWelcomeReady;

  @override
  Future<void> setOnboardAndWelcomeReady(bool ready) {
    return _provider.setOnboardAndWelcomeReady(ready);
  }

}
