import 'package:auto_route/auto_route.dart';
import 'package:street_bank/features/authentication/domain/usecase/is_user_login_usecase.dart';
import 'package:street_bank/navigation/routes.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final IsUserLoginUsecase isUserLoginUsecase;

  AuthGuard(this.isUserLoginUsecase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final completed = isUserLoginUsecase();

    if (completed) {
      resolver.next(true);
    } else {
      router.push(
        LoginRoute(
          onLoginCallback: () {
            router.popUntilRoot();
            resolver.next(true);
          },
        ),
      );
    }
  }
}
