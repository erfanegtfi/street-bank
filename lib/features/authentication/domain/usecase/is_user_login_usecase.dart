import 'package:app_data/local/local_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsUserLoginUsecase {
  LocalRepository localRepository;
  IsUserLoginUsecase(this.localRepository);

  bool call() {
    return localRepository.isUserLogin();
  }
}
