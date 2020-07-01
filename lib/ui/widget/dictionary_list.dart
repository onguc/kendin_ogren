import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendin_ogren/constants/constants.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/repo/dictionary_repo.dart';
import 'package:kendin_ogren/ui/widget/row_list_view.dart';

class DictionaryList extends StatefulWidget {
  DictionaryListState dictionaryListState;
  final GlobalKey<ScaffoldState> scaffoldKey;

  DictionaryList({this.scaffoldKey}) {
    dictionaryListState = DictionaryListState();
  }

  @override
  State<StatefulWidget> createState() => dictionaryListState;
}

class DictionaryListState extends State<DictionaryList> {
  List<Dictionary> dictionaryList = List();

  @override
  void initState() {
    DictionaryRepo dictionaryRepo = DictionaryRepo();
    dictionaryRepo.getAll().then((values) {
      for (var i = 0; i < values.length; i++) {
        addItemInListView(values[i]);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: dictionaryList == null ? 0 : dictionaryList.length,
        itemBuilder: (BuildContext context, int position) {
          return RowListView(
              dictionary: dictionaryList[position],
              position: position,
              deleteItemFunction: _deleteItem);
        });
  }

  void addItemInListView(Dictionary dictionary) async {
    dictionary.colorIconListen = colorNotListen;
    setState(() {
//      dictionaryList.add(dictionary);
      dictionaryList.insert(0, dictionary);
    });
  }

  Function _deleteItem(var position) {
    DictionaryRepo repo = DictionaryRepo();
    repo.deleteTodo(dictionaryList[position].id);
    setState(() {
      dictionaryList.removeAt(position);
    });
  }

  void deleteItems() {
    DictionaryRepo repo = DictionaryRepo();
    repo.deleteAllTodos();
    setState(() {
      dictionaryList.clear();
    });
  }

//  FlutterSoundPlayer flutterSoundPlayer;
//  AudioPlayer audioPlayer = AudioPlayer();

}
