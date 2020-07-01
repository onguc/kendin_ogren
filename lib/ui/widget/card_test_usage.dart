import 'package:flutter/material.dart';
import 'package:kendin_ogren/ui/widget/ngc_button2.dart';
import 'package:kendin_ogren/ui/widget/ngc_text_field.dart';

class CardAddFolder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardAddFolderState();
}

class CardAddFolderState extends State<CardAddFolder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NgcTextField(labelText: "Klasör Adı"),
                SizedBox(height: 10),
                NgcButton2(
                  text: "Ekle",
                ),
              ],
            )),
      ),
    );
  }
}
