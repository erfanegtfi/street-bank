// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:street_bank/features/account/presenter/transactions/transaction_list_screen.dart'
    as _i4;
import 'package:street_bank/features/account/presenter/transfer/transfer_screen.dart'
    as _i5;
import 'package:street_bank/features/authentication/presenter/login_screen.dart'
    as _i2;
import 'package:street_bank/features/dashboard/presenter/dashboard_screen.dart'
    as _i1;
import 'package:street_bank/features/settings/presenter/settings_screen.dart'
    as _i3;

/// generated route for
/// [_i1.DashboardScreen]
class DashboardRoute extends _i6.PageRouteInfo<void> {
  const DashboardRoute({List<_i6.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    dynamic Function()? onLoginCallback,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(onLoginCallback: onLoginCallback, key: key),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i2.LoginScreen(
        onLoginCallback: args.onLoginCallback,
        key: args.key,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.onLoginCallback, this.key});

  final dynamic Function()? onLoginCallback;

  final _i7.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{onLoginCallback: $onLoginCallback, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i3.SettingsScreen]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute({List<_i6.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i4.TransactionListScreen]
class TransactionListRoute extends _i6.PageRouteInfo<void> {
  const TransactionListRoute({List<_i6.PageRouteInfo>? children})
    : super(TransactionListRoute.name, initialChildren: children);

  static const String name = 'TransactionListRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.TransactionListScreen();
    },
  );
}

/// generated route for
/// [_i5.TransferScreen]
class TransferRoute extends _i6.PageRouteInfo<void> {
  const TransferRoute({List<_i6.PageRouteInfo>? children})
    : super(TransferRoute.name, initialChildren: children);

  static const String name = 'TransferRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.TransferScreen();
    },
  );
}
