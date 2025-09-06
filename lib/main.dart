import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/app.dart';
import 'package:street_bank/app/di/injector.dart';

void main() async {
  configureDependencies();

  runApp(ProviderScope(observers: const [], child: MyApp()));
}
