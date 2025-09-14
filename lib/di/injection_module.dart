import 'package:app_data/local/local_storage.dart';
import 'package:app_data/local/local_storage_impl.dart';
import 'package:app_data/remote/api_end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bank/di/injector.dart';
import 'package:app_data/remote/configs/dio_configuration.dart';
import 'package:dio/dio.dart';
import 'package:street_bank/database/database.dart';
import 'package:street_bank/navigation/navigation_service.dart';

@module
abstract class AppModule {
  @Named("baseUrl")
  @LazySingleton(order: -3)
  String get basetUrl => ApiDomain.baseDomain;

  @lazySingleton
  NavigationService get navigationService => NavigationService();

  @preResolve
  @LazySingleton(order: -2)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @LazySingleton(order: -1)
  LocalStorage get userRepository {
    return LocalStorageImpl(locator<SharedPreferences>());
  }

  @LazySingleton(order: -3)
  Dio get dio {
    return AppDio().getDio();
  }

  @preResolve
  @LazySingleton(order: -3)
  Future<BankDatabase> initDatabase() async {
    final database = await $FroomBankDatabase.databaseBuilder('bank_database.db').addMigrations([]).build();

    return database;
  }
}
