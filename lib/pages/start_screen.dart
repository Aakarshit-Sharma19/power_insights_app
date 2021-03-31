import 'package:flutter/material.dart';
import 'package:power_insights/constants.dart';
import 'package:power_insights/routes.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          children: [
            Text(
              'Power Insights',
              style: TextStyle(fontSize: 50.0, color: Colors.white),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.info),
              child: Hero(
                tag: login_tag,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) =>
                      EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0, bottom: 10.0)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white)),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
