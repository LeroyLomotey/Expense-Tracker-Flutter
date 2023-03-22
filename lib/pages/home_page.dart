import 'package:flutter/material.dart';

import '../analytics.dart';
import '../keys.dart';
import '../user.dart';

import '../widgets/transaction_list.dart';
import '../widgets/transaction_form.dart';
import '../widgets/chart.dart';
import '../widgets/switches.dart';
import '../widgets/card.dart';
import '../widgets/alert.dart';

class HomePage extends StatelessWidget {
  final User cUser;
  const HomePage({super.key, required this.cUser});

  void showTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        context: ctx,
        builder: (bCtx) {
          return Wrap(
            children: const [
              TransactionForm(),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    TextEditingController changeNameController =
        TextEditingController(text: cUser.name);
    TextEditingController changeBalanceController =
        TextEditingController(text: cUser.balance.toStringAsFixed(2));

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            children: [
              //------------------------Debit Card
              const DebitCard(),
              //--------------------Weekly spending Chart
              const Chart(),
              //--------------------------Transactions
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: const Text(
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      'Transactions')),

              const TransactionList(),
            ],
            //------------------------------------------------------------------------------------------
          ),
        ),
        drawer: Drawer(
          width: 250,
          backgroundColor: Keys.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: ListView(reverse: true, children: [
            const SizedBox(
              height: 24,
            ),
            ListTile(
                title: const Text('Reset Transactions',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white)),
                leading: const Icon(Icons.delete_sweep_outlined,
                    color: Colors.white),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => CreateAlert(
                          title: 'Are you sure?',
                          content:
                              'Once you delete your transactions, you cannot restore them!',
                          function: cUser.resetTransactions));
                  //Navigator.pop(context);
                }),
            ListTile(
                title: const Text('Policies',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white)),
                leading:
                    const Icon(Icons.receipt_outlined, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                }),
            //Dark mode and Notification switch build
            const Switches()
          ]),
        ),
        //--------------------------------------------------------------------
        endDrawer: Drawer(
          width: 250,
          backgroundColor: Keys.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: CircleAvatar(
                  minRadius: 40,
                  maxRadius: 40,
                ),
              ),
              Divider(
                color: Keys.tertiaryColor,
              ),
              //----------------------------------Name
              ListTile(
                title: TextField(
                    controller: changeNameController,
                    onTap: () => changeNameController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: changeNameController.text.length)),
                    onSubmitted: (b) =>
                        cUser.setName(changeNameController.text),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.characters,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.account_circle, color: Colors.white),
                trailing: const Icon(Icons.edit, color: Colors.white),
                onTap: () {},
              ),
              //------------------------------------Balance
              ListTile(
                title: TextField(
                    controller: changeBalanceController,
                    //onTap: () => changeBalanceController.clear(),
                    onSubmitted: (b) {
                      if (Analytics.isNumeric(changeBalanceController.text)) {
                        if (double.parse(changeBalanceController.text) >= 0) {
                          cUser.setBalance(
                              double.parse(changeBalanceController.text));
                        }
                      }
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.account_balance, color: Colors.white),
                trailing: const Icon(Icons.edit, color: Colors.white),
                onTap: () {},
              ),
              //-------------------------------------Currency
              ListTile(
                title: PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  iconSize: 24,
                  position: PopupMenuPosition.under,
                  itemBuilder: (BuildContext context) => Keys.currencies.keys
                      .map((choice) => PopupMenuItem(
                            value: choice,
                            child: Text(choice),
                          ))
                      .toList(),
                  onSelected: (c) => cUser.setCurrency(c),
                  child: Text(
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      cUser.currency),
                ),
                leading:
                    const Icon(Icons.currency_exchange, color: Colors.white),
                trailing: const Icon(Icons.edit, color: Colors.white),
                onTap: () {},
              ),
            ],
          ),
        ),
        //--------------------------------------------------------------------
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 0,
          color: Keys.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              //------------settings button
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.settings, color: Colors.white));
              }),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/');
                  },
                  icon: const Icon(Icons.home, color: Colors.white)),
              const Spacer(flex: 4),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/analyticsPage');
                  },
                  icon: const Icon(Icons.bar_chart, color: Colors.white)),
              const Spacer(),
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.person, color: Colors.white));
              }),
              const Spacer(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          splashColor: Keys.primaryColor,
          backgroundColor: Keys.primaryColor,
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {
            showTransactionForm(context);
          },
        ),
      ),
    );
  }
}
