import 'package:flutter/material.dart';

class NgcTextField extends StatefulWidget {
  NgcTextField({Key key, this.labelText, this.controller}) : super(key: key);

  @override
  _NgcTextFieldState createState() => _NgcTextFieldState();

  final String labelText;
  final controller;
}

class _NgcTextFieldState extends State<NgcTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: widget.controller,
//        obscureText: true,  //passord şeklinde gözüktürüyor galiba
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
