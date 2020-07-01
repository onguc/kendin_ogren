import 'package:flutter/material.dart';
import 'package:kendin_ogren/ui/widget/custom_button.dart';
import 'package:kendin_ogren/ui/widget/new_email.dart';

class LoginPage extends StatefulWidget {
//  LoginPage({Key key, this.title}) :super(key: key);
//
//  final String title;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[

                CustomButton(),
                NewEmail(),
//                CardAddDictionary(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
