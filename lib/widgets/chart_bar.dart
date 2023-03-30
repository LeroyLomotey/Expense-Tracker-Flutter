import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentTotal;
  const ChartBar(
      {super.key,
      required this.label,
      required this.amount,
      required this.percentTotal});

  @override
  Widget build(BuildContext context) {
    print(percentTotal);
    return Column(children: [
      //--------------------------Amount
      Text(amount.toStringAsFixed(0)),
      const Divider(),
      SizedBox(
        height: 80,
        width: 20,
        child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Container(
              decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(0),
          )),
          FractionallySizedBox(
              heightFactor: percentTotal != 0 ? percentTotal : 0.01,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 149, 117, 205),
                      Colors.blue
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(5)),
              )),
        ]),
      ),
      const Divider(),
      Text(label)
    ]);
  }
}
