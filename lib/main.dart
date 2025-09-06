import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/app.dart';
import 'package:street_bank/app/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await serviceLocator.allReady();
  runApp(ProviderScope(observers: const [], child: MyApp()));
}
