import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/model/voice.dart';
import 'package:kendin_ogren/repo/dictionary_repo.dart';
import 'package:kendin_ogren/repo/voice_repo.dart';
import 'package:kendin_ogren/ui/widget/buttons/drop_down_button_folder.dart';

import '../buttons/button_record_voice.dart';
import '../ngc_button2.dart';
import '../ngc_text_field.dart';

class AlertAddDictionary extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function addItemInListView;

  const AlertAddDictionary({
    Key key,
    this.scaffoldKey,
    this.addItemInListView,
  }) : super(key: key);

  @override
  _AlertAddDictionaryState createState() => _AlertAddDictionaryState();
}

class _AlertAddDictionaryState extends State<AlertAddDictionary> {
  final controllerWord = TextEditingController();
  final controllerExpl = TextEditingController();

  String pathVoice = "";

  Folder selectedFolder;
  DropDownButtonFolder dropDownButtonFolder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dropDownButtonFolder = DropDownButtonFolder();

    return SingleChildScrollView(
      child: AlertDialog(
        title: Text("Kelime Ekle",
            style: TextStyle(fontSize: 15, color: Colors.blue)),
        content: Container(
          height: 215,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                dropDownButtonFolder,
                SizedBox(height: 2),
                NgcTextField(controller: controllerWord, labelText: "Kelime"),
                SizedBox(height: 5),
                NgcTextField(controller: controllerExpl, labelText: "Açıklama"),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    ButtonRecordVoice(),
                    Flexible(fit: FlexFit.tight, child: SizedBox(width: 20)),
                    ButtonRecordVoice(),
                    Flexible(fit: FlexFit.tight, child: SizedBox(width: 20)),
                    NgcButton2(
                      onPressed: () {
                        _addDictionary();
                      },
                      text: "Ekle",
                    )
                  ],
                )
//          NgcTextField(labelText: "Ses Kaydı"),
//                ButtonBar(
//                  alignment: MainAxisAlignment.end,
//                  mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//,
//                    ,
//                  ],
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addDictionary() {
    Dictionary dictionary = Dictionary();
    dictionary.word = controllerWord.text;
    dictionary.explanation = controllerExpl.text;
//    dictionary.idFolder = dropDownButtonFolder.selectedFolder.id;

    DictionaryRepo repo = DictionaryRepo();
    repo.add(dictionary).then((onValue) {
      if (onValue > 0) {
        dictionary.id = onValue;
        controllerWord.clear();
        controllerExpl.clear();
//        showSnackBar("Kelime Eklendi");

        Voice voiceWord = Voice();
        voiceWord.name = pathVoice;
        voiceWord.idDictionary = dictionary.id;

        Voice voiceExpl = Voice();
        voiceExpl.name = pathVoice;
        voiceExpl.idDictionary = dictionary.id;

        VoiceRepo voiceRepo = VoiceRepo();
        var add = voiceRepo.add(voiceWord);
        add.then((value) => voiceWord.id = value);

        var add2 = voiceRepo.add(voiceExpl);
        add2.then((value) => voiceExpl.id = value);

        dictionary.voiceWord = voiceWord;
        dictionary.voiceExplanation = voiceExpl;
        widget.addItemInListView(dictionary);
      }
    });
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
//    Scaffold.of(context).showSnackBar(snackBar);
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
