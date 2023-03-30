import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../analytics.dart';
import '../keys.dart';

import '../user.dart';
import '../widgets/transaction_list.dart';
import '../widgets/transaction_form.dart';
import '../widgets/chart.dart';
import '../widgets/switches.dart';
import '../widgets/card.dart';
import '../widgets/alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late User cUser; //wait for User
  late Box box;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    box = Hive.box('myData');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    //Save if app is closing
    if (state == AppLifecycleState.inactive) {
      if (box.containsKey(1)) {
        // if previous session saved
        box.delete(1);
        print('${box.get(1)?.name} has been removed');
      }
      box.put(1, cUser);

      print('Session saved for ${cUser.name}');
    }
  }

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
    cUser = Provider.of<User>(context);

    TextEditingController changeNameController =
        TextEditingController(text: cUser.name);
    TextEditingController changeBalanceController =
        TextEditingController(text: cUser.balance.toStringAsFixed(2));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      'Transactions')),

              const TransactionList(),
            ],
            //------------------------------------------------------------------------------------------
          ),
        ),
        drawer: Drawer(
          child: ListView(reverse: true, children: [
            const SizedBox(
              height: 24,
            ),
            ListTile(
                title: const Text(
                  'Reset Transactions',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                leading: const Icon(
                  Icons.delete_sweep_outlined,
                ),
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
                title: const Text(
                  'Policies',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                leading: const Icon(Icons.receipt_outlined),
                onTap: () {
                  Navigator.pop(context);
                }),
            //Dark mode and Notification switch build
            Switches()
          ]),
        ),
        //--------------------------------------------------------------------
        endDrawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/avatar.png'),
                            fit: BoxFit.fitHeight))),
              ),

              Divider(
                color: Colors.white,
              ),
              //----------------------------------Name
              ListTile(
                title: TextField(
                    controller: changeNameController,
                    onTap: () => changeNameController.clear(),
                    onEditingComplete: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      cUser.setName(changeNameController.text);
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.account_circle),
                trailing: const Icon(Icons.edit),
              ),
              //------------------------------------Balance
              ListTile(
                title: TextField(
                    controller: changeBalanceController,
                    onTap: () => changeBalanceController.clear(),

                    /*
                    onTap: () => changeBalanceController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: changeBalanceController.text.length)),
                            */
                    onEditingComplete: () {
                      if (Analytics.isNumeric(changeBalanceController.text)) {
                        if (double.parse(changeBalanceController.text) >= 0) {
                          cUser.setBalance(
                              double.parse(changeBalanceController.text));
                        }
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.account_balance),
                trailing: const Icon(Icons.edit),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      cUser.currency),
                ),
                leading: const Icon(Icons.currency_exchange),
                trailing: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
        //--------------------------------------------------------------------
        bottomNavigationBar: BottomAppBar(
          notchMargin: 0,
          // color: Keys.primaryColor,
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
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ));
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
