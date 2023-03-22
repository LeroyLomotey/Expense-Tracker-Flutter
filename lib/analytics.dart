import 'dart:collection';

import 'package:expense_tracker/transaction.dart';
import 'package:expense_tracker/user.dart';

class Analytics {
  User cUser;
  List<dynamic> weeklyExpenseType = [];
  List<dynamic> monthlyExpenseType = [];

  Analytics(this.cUser) {
    List<Transaction> weeklyT = cUser.getRecentTransactions(7);
    List<Transaction> monthlyT = cUser.getRecentTransactions(30);
    weeklyExpenseType = expensesByType(weeklyT);
    monthlyExpenseType = expensesByType(monthlyT);
  }

  List<dynamic> expensesByType(List<Transaction> transactions) {
    Map<String, double> topExpenses = HashMap();
    double totalExpense = 0;
    double totalIncome = 0;

    for (Transaction t in transactions) {
      if (t.type != 'Income') {
        totalExpense += t.amount;
        if (topExpenses.isEmpty || !topExpenses.containsKey(t.type)) {
          topExpenses.addAll({t.type: t.amount});
        } else {
          topExpenses.update(t.type, (value) => (value + t.amount));
        }
      } else {
        totalIncome += t.amount;
      }
    }

    topExpenses.forEach((key, value) {
      topExpenses.update(key, (value) => (value / totalExpense * 100));
    });

    return [topExpenses, totalExpense, totalIncome];
  }

  static bool isNumeric(String value) {
    try {
      double.parse(value);
    } catch (e) {
      return false;
    }
    return true;
  }
}
