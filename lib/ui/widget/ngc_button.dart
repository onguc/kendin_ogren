import 'package:flutter/material.dart';

class NgcButton extends StatefulWidget {
//  NgcButton({Key key, this.text}) : super(key: key);
  NgcButton({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  _NgcButtonState createState() => _NgcButtonState();

//  final String text;
////  final Color textColor;
////  final Color buttonColor;
////  final Function() onPressed;

  String text;
  Function() onPressed;
}

class _NgcButtonState extends State<NgcButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      child: Text(widget.text,
          style: TextStyle(fontSize: 20)),
    );
  }
}
