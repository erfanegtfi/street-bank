import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/authentication/presenter/login_screen.dart';
import 'package:street_bank/features/dashboard/presenter/dashboard_screen.dart';
import 'package:street_bank/features/home/home_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(homeProvider);

    if (isLoggedIn) {
      return DashboardScreen();
    } else {
      return LoginScreen();
    }
  }
}
