import 'package:flutter/material.dart';
import 'package:power_insights/constants.dart';
import 'package:power_insights/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    controller: nameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
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
                        Navigator.pushNamed(context, Routes.insights);
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
