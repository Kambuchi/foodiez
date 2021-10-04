import 'package:firebase_auth/firebase_auth.dart';
import 'get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/providers/local/preferences_provider.dart';
import '../data/providers/remote/food_menu_provider.dart';
import '../data/providers/remote/websocket_provider.dart';
import '../data/repositories/account_repository.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/food_menu_repository.dart';
import '../data/repositories/preferences_reposiory.dart';
import '../data/repositories/sign_up_repository.dart';
import '../data/repositories/websocket_repository.dart';
import '../data/repositories_impl/authentication_repository_impl.dart';
import '../data/repositories_impl/food_menu_repository_impl.dart';
import '../data/repositories_impl/account_repository_impl.dart';
import '../data/repositories_impl/preferences_reposiory_impl.dart';
import '../data/repositories_impl/sign_up_repository_impl.dart';
import '../data/repositories_impl/websocket_repository_impl.dart';

typedef VoidCallBack = void Function();

abstract class DependencyInjection {
  static Future<void> initialize() async {
    final preferences = await SharedPreferences.getInstance();

    final wsProvider = WebsocketProvider();
    final PreferencesProvider preferencesProvider =
        PreferencesProvider(preferences);

    final AutheticationRepository autheticationRepository =
        AutheticationRepositoryImpl(FirebaseAuth.instance);

    final FoodMenuRepositoryImpl foodMenuRepository =
        FoodMenuRepositoryImpl(FoodMenuProvider());

    final WebsocketRepositoryImpl websocketRepository =
        WebsocketRepositoryImpl(wsProvider);

    final PreferencesRepositoryImpl preferencesRepository =
        PreferencesRepositoryImpl(preferencesProvider);

    final AccountRepository accountRepository =
        AccountRepositoryImpl(FirebaseAuth.instance);

    final singUpRepository = SignUpRepositoryImpl(FirebaseAuth.instance);

    Get.i.put<AutheticationRepository>(autheticationRepository);
    Get.i.put<SignUpRepository>(singUpRepository);
    Get.i.put<FoodMenuRepository>(foodMenuRepository);
    Get.i.put<WebsocketRepository>(websocketRepository);
    Get.i.put<PreferencesRepository>(preferencesRepository);
    Get.i.put<String>("API_KEY", tag: "apiKey");
    Get.i.put<String>("SECRET", tag: "secret");
    Get.i.put<AccountRepository>(accountRepository);

    final VoidCallBack dispose = () {
      wsProvider.dispose();
    };
    Get.i.put<VoidCallBack>(dispose, tag: 'dispose');
  }

  static void dispose() {
    final dispose = Get.i.find<VoidCallBack>(tag: 'dispose');
    dispose();
  }
}
