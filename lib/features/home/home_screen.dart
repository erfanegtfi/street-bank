import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/authentication/presenter/login_screen.dart';
import 'package:street_bank/features/dashboard/presenter/dashboard_screen.dart';
import 'package:street_bank/features/home/home_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(homeProvider);

    if (isLoggedIn) {
      return DashboardScreen();
    } else {
      return LoginScreen();
    }
  }
}
