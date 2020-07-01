import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/repo/folder_repo.dart';
import 'package:kendin_ogren/ui/widget/ngc_button2.dart';
import 'package:kendin_ogren/ui/widget/ngc_text_field.dart';

import 'ngc_button.dart';

class CardAddFolder extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CardAddFolder({Key key, this.scaffoldKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CardAddFolderState();
}

class CardAddFolderState extends State<CardAddFolder> {
  final controllerKlasorAdi = TextEditingController();

  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  String _name;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NgcTextField(controller: controllerKlasorAdi, labelText: "Klasör Adı"),
          SizedBox(height: 10),
          RaisedButton(child: Text("Ekle"), onPressed: _ekle)
//        NgcButton(text: "Ekle", onPressed: _ekle()),
        ],
      ),
    );
  }

  _ekle() async {
//    final form = formKey.currentState;
//    if (form.validate()) {
//      setState(() {
//        _isLoading = true;
//        form.save();
//      });
//    }
    FolderRepo repo = new FolderRepo();
    Folder folder = new Folder();
    folder.name = controllerKlasorAdi.text;
    folder.createDate = DateTime.now();
    folder.updateDate = DateTime.now();
    repo.add(folder).then((onValue){
      debugPrint(onValue.toString());
      if(onValue>0){
        //liste yenile filan yapılabilir
        controllerKlasorAdi.clear();
//        Navigator.pop(context); // popup kapatır
      }
    });

    List folderList = await repo.getAll();
    int i = 0;
    folderList.forEach((row) {
      print("$i. row = $row");
      i++;
    });
    showSnackBar("Eklendi");
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
//    Scaffold.of(context).showSnackBar(snackBar);
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
