import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import './transaction.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends ChangeNotifier {
  @HiveField(0)
  String name;
  @HiveField(1)
  double balance;
  @HiveField(3)
  String currency;
  @HiveField(4)
  List<Transaction> transactions = [];
  @HiveField(5)
  bool darkMode;
  @HiveField(6)
  bool notify;

  User(
      {required this.name,
      required this.balance,
      this.darkMode = false,
      this.notify = false,
      this.currency = 'Dollar'}) {
    notifyListeners();
  }

  List<Transaction> getTransactions() {
    return transactions;
  }

  List<Transaction> getRecentTransactions(int length) {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: length),
      ));
    }).toList();
  }

  void addTransaction(Transaction t) {
    if (t.type == 'Income') {
      balance = balance + t.amount;
    } else {
      balance = balance - t.amount;
    }
    transactions.add(t);
    notifyListeners();
  }

  void removeTransaction(Transaction t) {
    if (t.type == 'Income') {
      balance = balance - t.amount;
    } else {
      balance = balance + t.amount;
    }
    transactions.remove(t);
    notifyListeners();
  }

  void resetTransactions() {
    transactions = [];
    notifyListeners();
  }

  void setBalance(double b) {
    balance = b;
    notifyListeners();
  }

  void setName(String n) {
    name = n;
    notifyListeners();
  }

  void setDarkMode(bool m) {
    darkMode = m;
    notifyListeners();
  }

  void setCurrency(String c) {
    currency = c;
    print(currency);
    notifyListeners();
  }

  void setNotify(bool m) {
    notify = m;
    print('DNotifications set to $notify');
    notifyListeners();
  }
}
