import 'package:auto_route/auto_route.dart';
import 'package:street_bank/features/authentication/domain/usecase/is_user_login_usecase.dart';
import 'package:street_bank/navigation/auth_guard.dart';
import 'package:street_bank/navigation/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final IsUserLoginUsecase isUserLoginUsecase;
  AppRouter(this.isUserLoginUsecase);

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: DashboardRoute.page, initial: true, guards: [AuthGuard(isUserLoginUsecase)]),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: TransferRoute.page),
    AutoRoute(page: TransactionListRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
