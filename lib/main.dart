import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './pages/analytics_page.dart';
import './ThemeManager.dart';
import 'user.dart';

void main() async {
  await Hive.initFlutter(); //Launch Hive
  Hive.registerAdapter(UserAdapter()); //Convert User class from binary storage
  Hive.registerAdapter(
      TransactionAdapter()); //Convert Transaction class from binary storage

  runApp(MyApp());

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  ThemeManager? getTheme;
  ThemeManager? themeManager;

  //---Access Data storage
  Future _getData() async {
    await Hive.openBox('myData');
    final box = await Hive.box('myData');
    //If nothing found, default to John Doe
    user =
        await box.get(1) ?? User(name: 'John Doe', balance: 0, darkMode: false);

    getTheme = await ThemeManager(darkMode: await user!.darkMode);
    //get saved theme
    print('${await box.get(1)?.name} from saved session');
    print('${await box.get(1)?.balance} balance from session');
    print(user?.name);
    return await getTheme;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        } else {
          return ChangeNotifierProvider(
              create: (context) => user, //Check if previous session exists
              child: ChangeNotifierProvider(
                create: (context) => getTheme,
                builder: (context, child) {
                  themeManager = Provider.of<ThemeManager>(context);
                  return MaterialApp(
                    showPerformanceOverlay: false,
                    title: 'Expense Tracker',
                    theme: themeManager!.theme,
                    initialRoute: '/',
                    routes: {
                      '/': (context) => HomePage(),
                      '/analyticsPage': (context) => AnalyticsPage(),
                    },
                  );
                },
              ));
        }
      }),
    );
  }
}
