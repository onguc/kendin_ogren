import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kendin_ogren/constants/constants.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/ui/service/sound_translate.dart';

import 'card_update_dictionary.dart';

class RowListView extends StatefulWidget {
  const RowListView(
      {Key key,
      @required this.dictionary,
      @required this.position,
      this.deleteItemFunction})
      : super(key: key);

//  final List<Dictionary> dictionaryList;
  final Dictionary dictionary;
  final int position;
  final Function deleteItemFunction;

  @override
  _RowListViewState createState() => _RowListViewState();
}

class _RowListViewState extends State<RowListView> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.15,
      child: Card(
        color: Colors.white,
        elevation: 15.0,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 5),
                  child: Column(
                    children: <Widget>[
                      Text("${widget.dictionary.viewsCounts.length}"),
                      Text("${widget.position}",
                          style: TextStyle(color: Colors.red))
                    ],
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.dictionary.word, style: titleStyle),
                      Text(widget.dictionary.explanation,
                          style: TextStyle(color: Colors.green))
                    ]),
                Expanded(child: SizedBox()),
                IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(iconDataListen,
                        color: widget.dictionary.colorIconListen),
                    tooltip: 'Dinle',
                    autofocus: true,
                    highlightColor: Colors.red,
                    onPressed: () {
                      setState(() {
                        widget.dictionary.colorIconListen = colorListen;
                      });
                      _startListen(widget.position);
                    })
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Dahası',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => showAlertDialogKelimeGuncelle(widget.position)),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            widget.deleteItemFunction(widget.position);
          },
        )
      ],
    );
  }

  showAlertDialogKelimeGuncelle(int position) {
    var selectedDictionary = widget.dictionary;

    return showDialog(
        context: this.context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("Kelime Ekle",
                  style: TextStyle(fontSize: 15, color: Colors.blue)),
              content: Container(
//                child: CardAddDictionary(
//                    scaffoldKey: scaffoldKey, addItemDictionary: addItemDictionary),
                  child: CardUpdateDictionary(
                      scaffoldKey: null,
                      updateItemInListView: updateItemInListView,
                      selectedDictionary: selectedDictionary)),
            ),
          );
        }).then((value) {});
  }

  void _startListen(int position) async {
    SoundTranslate soundTranslate = SoundTranslate();
    soundTranslate.startPlay(
        widget.dictionary.voiceWord.name, position, onFinishListen);
  }

  Future onFinishListen(int position) {
    setState(() {
      widget.dictionary.colorIconListen = colorNotListen;
    });
  }

  void updateItemInListView(Dictionary dictionary) {
    setState(() {
      int x = 0;
//      widget.dictionary = dictionary;
    });
//    dictionaryList.forEach((element) {
//      if (element.id == dictionary.id) {
//        setState(() {
//          element = dictionary;
//          return;
//        });
//      }
//    });
  }
}
