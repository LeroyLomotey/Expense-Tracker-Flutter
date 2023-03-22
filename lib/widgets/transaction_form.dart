import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl.dart';

import '../transaction.dart';
import '../keys.dart';
import '../user.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  String _date = 'Enter date';
  String _type = 'Choose type';
  DateTime dateInput = DateTime.now();
  String typeInput = 'Miscellanous';

  bool isNumeric(String str) {
    try {
      double.parse(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final User cUser = Provider.of<User>(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            //--------------------------------------Title
            ListTile(
              leading: Icon(Icons.edit_rounded, color: Keys.tertiaryColor),
              title: TextField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                maxLength: 30,
                onSubmitted: (ctx) => '',
              ),
            ),
            //----------------------------------------Amount
            ListTile(
              leading: Icon(
                Icons.paid,
                color: Keys.tertiaryColor,
              ),
              title: TextField(
                  controller: _amount,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: const TextInputType.numberWithOptions()),
            ),
            //-----------------------------------------Date
            GestureDetector(
              child: ListTile(
                title: Text(
                  _date,
                  style: const TextStyle(color: Colors.black54),
                ),
                leading: Icon(
                  Icons.calendar_today,
                  color: Keys.tertiaryColor,
                ),
              ),
              onTap: () async {
                DateTime? datePicked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (datePicked != null) {
                  setState(() {
                    dateInput = datePicked;
                    _date = Transaction.getDate(datePicked);
                  });
                }

                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),

            //--------------------------------------------Transaction Type
            ListTile(
              leading: Icon(
                  size: 24, Icons.receipt_rounded, color: Keys.tertiaryColor),
              title: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                iconSize: 24,
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) => Keys.transactionType.keys
                    .map((type) => PopupMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onSelected: (value) => setState(() {
                  _type = value;
                  typeInput = value;
                }),
                child: Text(
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.black54),
                    _type),
              ),
            ),

            //---------------------------------------------------------------Add new Transaction
            IconButton(
              color: Keys.tertiaryColor,
              onPressed: () {
                if (_title.text.isNotEmpty &&
                    _amount.text.isNotEmpty &&
                    isNumeric(_amount
                        .text)) //if fields filled out add new Transaction
                {
                  if (double.parse(_amount.text) >= 0) {
                    Transaction newT = Transaction(
                        id: DateTime.now().toString(),
                        title: _title.text,
                        amount: double.parse(_amount.text),
                        type: typeInput,
                        date: dateInput);

                    cUser.addTransaction(newT);

                    _title.text = '';
                    _amount.text = '';
                    _date = '';
                    dateInput = DateTime.now();
                    _type = 'Choose type';

                    Navigator.pop(context);
                  }
                }
              },
              icon: const Icon(
                Icons.done_all,
              ),
              iconSize: 50,
            ),
          ],
        ),
      ),
    );
  }
}
