import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/di/injector.dart';
import 'package:street_bank/features/authentication/domain/usecase/is_user_login_usecase.dart';

final homeProvider = NotifierProvider.autoDispose<HomeNotifier, bool>(HomeNotifier.new);

class HomeNotifier extends AutoDisposeNotifier<bool> {
  late final IsUserLoginUsecase _isUserLoginUsecase;

  @override
  bool build() {
    _isUserLoginUsecase = serviceLocator<IsUserLoginUsecase>();
    return _isUserLoginUsecase();
  }
}
