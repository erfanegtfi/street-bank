import 'package:app_data/local/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorageImpl extends LocalStorage {
  final SharedPreferences prefs;
  static const String userStatus = 'user_status';

  LocalDataStorageImpl(this.prefs);

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
