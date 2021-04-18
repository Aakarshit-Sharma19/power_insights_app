import 'package:flutter/material.dart';
import 'package:power_insights/pages/device_info_screen.dart';
import 'package:power_insights/pages/home_page.dart';
import 'package:power_insights/pages/insights_screen.dart';
import 'package:power_insights/pages/login_page.dart';
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
        Routes.home: (context) => HomePage(),
      },
      initialRoute: Routes.start,
    );
  }
}
