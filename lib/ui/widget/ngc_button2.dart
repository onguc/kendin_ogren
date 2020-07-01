import 'package:flutter/material.dart';

class NgcButton2 extends StatefulWidget {
//  NgcButton({Key key, this.text}) : super(key: key);
  NgcButton2(
      {Key key, this.text, this.textColor, this.buttonColor, this.onPressed})
      : super(key: key);

  @override
  _NgcButtonState createState() => _NgcButtonState();

//  final String text;
////  final Color textColor;
////  final Color buttonColor;
////  final Function() onPressed;

  String text;
  Color textColor;
  Color buttonColor;
  Function() onPressed;
}

class _NgcButtonState extends State<NgcButton2> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: widget.buttonColor,
      onPressed: widget.onPressed,
      child: Text(widget.text,
          style: TextStyle(color: widget.textColor, fontSize: 20)),
    );
  }
}
