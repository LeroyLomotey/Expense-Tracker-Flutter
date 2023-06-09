import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../user.dart';
import '../keys.dart';
import '../analytics.dart';
import '../pie_chart_section_data.dart';

import '../widgets/pie_chart.dart';
import '../widgets/switches.dart';
import '../widgets/alert.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int? groupedValue = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    User cUser = Provider.of<User>(context);
    //ThemeManager themeManager = Provider.of<ThemeManager>(context);
    Analytics data = Analytics(cUser);

    List<PieChartSectionData> weeklyChartList =
        PieData.getSections(data.weeklyExpenseType[0]);
    List<PieChartSectionData> monthlyChartList =
        PieData.getSections(data.monthlyExpenseType[0]);

    TextEditingController changeNameController =
        TextEditingController(text: cUser.name);
    TextEditingController changeBalanceController =
        TextEditingController(text: cUser.balance.toStringAsFixed(2));
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: Keys.pagePadding,
          child: Column(
            children: [
              CupertinoSlidingSegmentedControl(
                  thumbColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                  padding: const EdgeInsets.all(5),
                  groupValue: groupedValue,
                  children: {
                    0: buildSegment('Weekly'),
                    1: buildSegment('Monthly'),
                  },
                  onValueChanged: (groupedValue) {
                    setState(() {
                      this.groupedValue = groupedValue;
                    });
                  }),
              const Divider(color: Colors.transparent),
              //-----------------------------Balance
              Text(
                  '${Keys.currencies[cUser.currency]}${cUser.balance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20)),
              const Divider(color: Colors.transparent),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //--------------------Total Income
                  Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        width: 150,
                        height: 100,
                        padding: Keys.pagePadding,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              const Text(
                                'Income',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(flex: 2),
                              Text(
                                  '${groupedValue == 0 ? data.weeklyExpenseType[2].toStringAsFixed(2) : data.monthlyExpenseType[2].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 20)),
                              const Spacer(flex: 3),
                            ]),
                      )),

                  //--------------------Total Expenses
                  Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        width: 150,
                        height: 100,
                        padding: Keys.pagePadding,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(flex: 1),
                              const Text('Expenses',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(flex: 2),
                              Text(
                                  '-${groupedValue == 0 ? data.weeklyExpenseType[1].toStringAsFixed(2) : data.monthlyExpenseType[1].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 20)),
                              const Spacer(flex: 3),
                            ]),
                      )),
                ],
              ),
              const Divider(color: Colors.transparent),
              //--------------------------Pie Chart
              cUser.transactions.isNotEmpty
                  ? PieChartWidget(
                      sections: groupedValue == 0
                          ? weeklyChartList
                          : monthlyChartList)
                  : const Text('No Transactions'),
            ],
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
                              fit: BoxFit.fitHeight)))),
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
                    textCapitalization: TextCapitalization.characters,
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
                    Navigator.pushNamed(context, '/');
                  },
                  icon: const Icon(Icons.home, color: Colors.white)),
              const Spacer(flex: 4),
              IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/analyticsPage');
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
      ),
    );
  }

  Widget buildSegment(String text) => Container(
        padding: const EdgeInsets.all(5),
        child: Text(text,
            style: const TextStyle(fontSize: 14, color: Colors.black)),
      );
}
