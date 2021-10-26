import 'package:flutter/material.dart';
import 'package:power_insights/pages/home_screen.dart';
import 'package:power_insights/pages/login_screen.dart';
import 'package:power_insights/pages/daily_insights_screen.dart';
import 'package:power_insights/pages/monthly_insights_screen.dart';
import 'package:power_insights/pages/start_screen.dart';
import 'package:power_insights/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.start: (context) => StartScreen(),
        Routes.login: (context) => LoginPage(),
        Routes.home: (context) => HomeScreen(),
        Routes.dailyInsights: (context) => DailyInsightsScreen(),
        Routes.monthlyInsights: (context) => MonthlyInsightsScreen()
      },
      initialRoute: Routes.start,
    );
  }
}
