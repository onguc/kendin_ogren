import 'package:flutter/cupertino.dart';
import 'package:kendin_ogren/model/base_model.dart';
import 'package:kendin_ogren/model/views_count.dart';
import 'package:kendin_ogren/model/voice.dart';

class Dictionary extends BaseModel {
  static const String TABLE_NAME = "DICTIONARY";

  Dictionary();
  String _word;
  String _explanation;
  Voice _voiceWord;
  Voice _voiceExplanation;

  int _idFolder;
  List<DictionaryViewsCount> _viewsCounts;

  Color colorIconListen;

  String get word => _word;

  set word(String value) => _word = value;

  String get explanation => _explanation;

  set explanation(String value) => _explanation = value;

  Voice get voiceWord => _voiceWord;

  set voiceWord(Voice value) => _voiceWord = value;

  int get idFolder => _idFolder;

  set idFolder(int value) => _idFolder = value;


  Voice get voiceExplanation => _voiceExplanation;

  set voiceExplanation(Voice value) {
    _voiceExplanation = value;
  }

  List<DictionaryViewsCount> get viewsCounts {
    if(_viewsCounts==null) _viewsCounts = List();
    return _viewsCounts;
  }

  set viewsCounts(List<DictionaryViewsCount> value) => _viewsCounts = value;

  Dictionary.fromMap(Map<String,dynamic > map) {
    fromMapBasic(map);
    _word = map["word"];
    _explanation = map["explanation"];
    _idFolder = map["idFolder"];
  }

  Map<String, dynamic> toMap() {
    var map = getMapBasic();
    map["word"] = _word;
    map["explanation"] = _explanation;
    map["idFolder"] = _idFolder;
    return map;
  }
}
