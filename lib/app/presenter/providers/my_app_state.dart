import 'package:street_bank/app/data/model/app_settings.dart';

abstract class MyAppState {
  final AppSettings appSettings;
  const MyAppState({required this.appSettings});
}

class InitialState extends MyAppState {
  InitialState({required super.appSettings});
}

class AppStateChangedState extends MyAppState {
  const AppStateChangedState({required super.appSettings});
}
