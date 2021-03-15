import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login to Power Insights"),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 10.0),
                TextField(
                  autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
