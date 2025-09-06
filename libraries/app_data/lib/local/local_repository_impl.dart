import 'package:app_data/local/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositoryImpl extends LocalRepository {
  final SharedPreferences prefs;
  static const String userStatus = 'user_status';

  LocalRepositoryImpl(this.prefs);

  @override
  bool isUserLogin() {
    bool? isUserLogin = prefs.getBool(userStatus);
    return isUserLogin ?? false;
  }

  @override
  setUserStatus(bool status) {
    prefs.setBool(userStatus, status);
  }
}
