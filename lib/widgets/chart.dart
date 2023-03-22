import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../transaction.dart';
import '../user.dart';
import 'chart_bar.dart';
import '../keys.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  List<Map<String, Object>> groupedTransactionValues(
      List<Transaction> recentTransactions) {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalAmount = 0;

      for (Transaction t in recentTransactions) {
        if (t.date.day == weekDay.day &&
            t.date.month == weekDay.month &&
            t.date.year == weekDay.year &&
            t.type != 'Income') {
          totalAmount += t.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  double weeklySpending(List<Map<String, Object>> groupedT) {
    return groupedT.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    List<Map<String, Object>> groupedT =
        groupedTransactionValues(cUser.getRecentTransactions(7));

    return Card(
        color: const Color.fromARGB(255, 245, 245, 245),
        elevation: 0,
        margin: Keys.pagePadding,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedT.map((data) {
              return ChartBar(
                  label: data['day'].toString(),
                  amount: (data['amount'] as double),
                  percentTotal: weeklySpending(groupedT) == 0
                      ? 0
                      : (data['amount'] as double) / weeklySpending(groupedT));
            }).toList(),
          ),
        ));
  }
}
