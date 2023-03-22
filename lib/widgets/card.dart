import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys.dart';
import '../user.dart';

class DebitCard extends StatefulWidget {
  const DebitCard({super.key});

  @override
  DebitCardState createState() => DebitCardState();
}

class DebitCardState extends State<DebitCard> {
  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    String currencySymbol = Keys.currencies[cUser.currency] as String;

    return Card(
      elevation: 5,
      shadowColor: Keys.primaryColor,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        width: 300,
        height: 180,
        padding: Keys.pagePadding,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Keys.secondaryColor, Keys.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------balance
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      '$currencySymbol${cUser.balance.toStringAsFixed(2)}'),
                  Divider(height: 8, color: Keys.secondaryColor),
                  const Text(
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      'Balance'),
                ]),
            //-------Card number
            const SizedBox(
              width: double.infinity,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 4,
                    wordSpacing: 12,
                    color: Colors.white),
                '**** **** **** 123',
              ),
            ),
            //-------Name VISA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                      wordSpacing: 4,
                      color: Colors.white,
                    ),
                    cUser.name,
                    overflow: TextOverflow.fade,
                  ),
                ),
                //const Spacer(),
                //Visa logo
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                        width: 50, height: 50, './assets/icons/visa.png')),

                /* Text(
                        style: TextStyle(color: Colors.white),
                        "VISA",
                        textAlign: TextAlign.end,
                      )*/
                //Image.asset(''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
