import 'package:flutter/foundation.dart';

class WalletBalance with ChangeNotifier {
  double _walletBalance = 0;
  double _cashBackBalance = 0;

  double get walletBalance {
    return _walletBalance;
  }

  set setWalletBalance(double walletBalance) {
    _walletBalance = walletBalance;
  }

  double get cashBackBalance {
    return _cashBackBalance;
  }

  set setCashBackBalance(double cashbackBalance) {
    _cashBackBalance = cashbackBalance;
  }
}
