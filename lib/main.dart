import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './user.dart';
import './pages/home_page.dart';
import './pages/analytics_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final User cUser = User(name: 'John Doe', balance: 10000, darkMode: false);
  final pages = {
    // const AnalyticsPage(),
    // HomePage(cUser: cUser),
  };
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>.value(
      value: cUser,
      child: MaterialApp(
        showPerformanceOverlay: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          //brightness: Brightness.dark
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Neon',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(cUser: cUser),
          '/analyticsPage': (context) => const AnalyticsPage(),
        },
      ),
    );
  }
}
