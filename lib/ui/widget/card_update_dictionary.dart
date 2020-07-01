import 'package:flutter/material.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/repo/dictionary_repo.dart';
import 'package:kendin_ogren/repo/folder_repo.dart';
import 'package:kendin_ogren/ui/widget/ngc_button2.dart';
import 'package:kendin_ogren/ui/widget/ngc_text_field.dart';

class CardUpdateDictionary extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function updateItemInListView;
  final Dictionary selectedDictionary;

  CardUpdateDictionary(
      {Key key,
      this.scaffoldKey,
      this.updateItemInListView,
      this.selectedDictionary})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CardUpdateDictionaryState();
}

class CardUpdateDictionaryState extends State<CardUpdateDictionary> {
  final controllerWord = TextEditingController();
  final controllerExpl = TextEditingController();

  Folder selectedFolder;
  List<Folder> folderList = List();

  @override
  void initState() {
    var selectedDictionary = widget.selectedDictionary;
    var idFolder = selectedDictionary.idFolder;

    FolderRepo folderRepo = FolderRepo();
    folderRepo.getAll().then((list) {
      setState(() {
        folderList = list;
        selectedFolder = folderList[idFolder];
        controllerWord.text = selectedDictionary.word;
        controllerExpl.text = selectedDictionary.explanation;
      });
      debugPrint(list.toString());
    });
    // TODO: implement initState
    super.initState();
  }

  _updateDictionary() {
    var selectedDictionary = widget.selectedDictionary;
    selectedDictionary.word = controllerWord.text;
    selectedDictionary.explanation = controllerExpl.text;
    selectedDictionary.idFolder = selectedFolder.id;
    selectedDictionary.updateDate = DateTime.now();

    DictionaryRepo repo = DictionaryRepo();
    repo.update(selectedDictionary).then((onValue) {
      if (onValue == 1) {
//        showSnackBar("Kelime Güncellendi");
        widget.updateItemInListView(selectedDictionary);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildContainerDropdownButton(),
          SizedBox(height: 2),
          NgcTextField(controller: controllerWord, labelText: "Kelime"),
          SizedBox(height: 2),
          NgcTextField(controller: controllerExpl, labelText: "Açıklama"),
          SizedBox(height: 2),
//          NgcTextField(labelText: "Ses Kaydı"),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_voice),
                iconSize: 30,
                onPressed: () {},
                highlightColor: Colors.green,
              ),
              NgcButton2(
                onPressed: () {
                  _updateDictionary();
                },
                text: "Güncelle",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildContainerDropdownButton() {
    return Container(
      width: double.infinity,
      child: DropdownButton<Folder>(
          isExpanded: true,
          itemHeight: kMinInteractiveDimension,
          value: selectedFolder,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 54,
          underline: Container(
            height: 1,
            color: Colors.blue,
          ),
          onChanged: (Folder data) {
            setState(() {
              selectedFolder = data;
            });
          },
          items: folderList.map<DropdownMenuItem<Folder>>((Folder folder) {
            return DropdownMenuItem<Folder>(
              value: folder,
              child: Text(folder.name),
            );
          }).toList()),
    );
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
//    Scaffold.of(context).showSnackBar(snackBar);
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
