import 'package:app_data/local/local_storage.dart';

class IsUserLoginUsecase {
  LocalStorage localRepository;
  IsUserLoginUsecase(this.localRepository);

  bool call() {
    return localRepository.isUserLogin();
  }
}
