import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountLocalStorage {
  double? getUserBalance();
  setUserBalance(double balance);
}

@Injectable(as: AccountLocalStorage)
class AccountLocalStorageImpl extends AccountLocalStorage {
  final SharedPreferences prefs;
  static const String userBalance = 'user_balance';

  AccountLocalStorageImpl(this.prefs);

  @override
  double? getUserBalance() {
    double? balance = prefs.getDouble(userBalance);
    return balance;
  }

  @override
  setUserBalance(double balance) {
    prefs.setDouble(userBalance, balance);
  }
}
