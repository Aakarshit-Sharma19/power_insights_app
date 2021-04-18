import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_insights/constants.dart';
import 'package:power_insights/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  final storage = new FlutterSecureStorage();

  Future<void> login() async {
    var response = await http.post(
      Uri.parse(
          'https://power-insights.herokuapp.com/api/accounts/api-auth-token/'),
      body: {'username': _email, 'password': _password},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      storage.write(key: 'token', value: body['token']);
      Navigator.pushNamed(context, Routes.home);
      final snackBar = SnackBar(content: Text('Login Successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (response.statusCode == 400) {
      final snackBar = SnackBar(
          content: Text('Wrong Email or Password! Check and Try Again'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Power Insights'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Hero(
                      tag: login_tag,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 50),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                    onChanged: (String value) {
                      _email = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onChanged: (String value) {
                      _password = value;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.blue;
                      })),
                      onPressed: () {
                        login();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
