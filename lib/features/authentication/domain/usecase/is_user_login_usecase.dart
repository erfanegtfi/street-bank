import 'package:app_data/local/local_repository.dart';

class IsUserLoginUsecase {
  LocalRepository localRepository;
  IsUserLoginUsecase(this.localRepository);

  bool call() {
    return localRepository.isUserLogin();
  }
}
