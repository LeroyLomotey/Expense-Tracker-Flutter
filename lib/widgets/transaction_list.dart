import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../transaction.dart';
import '../user.dart';
import '../keys.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  TransationListState createState() => TransationListState();
}

class TransationListState extends State<TransactionList> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: ListView.builder(
          itemCount: cUser.transactions.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: SizedBox(
                width: screenSize.width - 30,
                child: Card(
                    color: Colors.red.shade300,
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 20),
                          child: Icon(Icons.delete),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 20),
                          child: Icon(Icons.delete),
                        ),
                      ],
                    )),
              ),
              key: ValueKey<Transaction>(cUser.transactions[index]),
              onDismissed: (DismissDirection d) {
                setState(() {
                  cUser.removeTransaction(cUser.transactions[index]);
                  //tList.removeAt(index);
                });
              },
              child: SizedBox(
                width: screenSize.width - 30,
                child: Card(
                  elevation: 0,
                  color: const Color.fromARGB(255, 245, 245, 245),
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Icon
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                    colors: [
                                      Keys.primaryColor,
                                      Keys.secondaryColor
                                    ],
                                    begin: Alignment.topCenter,
                                  ).createShader(rect),
                              child: Keys.transactionType[
                                  cUser.transactions[index].type]),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Title
                            SizedBox(
                              width: 150,
                              child: Text(
                                  maxLines: 1,
                                  softWrap: true,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  cUser.transactions[index].title),
                            ),
                            //Date
                            Text(
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black26),
                              overflow: TextOverflow.ellipsis,
                              Transaction.getDate(
                                  cUser.transactions[index].date),
                            ),
                          ],
                        ),
                        //Transaction cost
                        Container(
                          width: 100,
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                              cUser.transactions[index].type != 'Income'
                                  ? '-${cUser.transactions[index].amount.toStringAsFixed(2)}'
                                  : cUser.transactions[index].amount
                                      .toStringAsFixed(2)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
