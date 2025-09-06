import 'package:app_data/local/local_repository.dart';
import 'package:app_data/local/local_repository_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bank/app/di/injector.dart';

@module
abstract class AppModule {
  @preResolve
  @LazySingleton(order: -2)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @LazySingleton(order: -1)
  LocalRepository get userRepository {
    return LocalRepositoryImpl(serviceLocator<SharedPreferences>());
  }
}
