import 'package:kendin_ogren/model/base_model.dart';

class DictionaryViewsCount extends BaseModel {
  static const String TABLE_NAME = "DICTIONARY_VIEW_COUNT";
  static const String KEY_ID_DICTIONARY = "idDictionary";
  static const String KEY_COUNT = "count";

  int idDictionary;

  int count;

  DictionaryViewsCount(this.idDictionary, this.count);

  Map<String, dynamic> toMap() {
    var map = super.getMapBasic();
    map[KEY_ID_DICTIONARY] = idDictionary;
    map[KEY_COUNT] = count;
    return map;
  }

  @override
  DictionaryViewsCount.fromMap(Map<String, dynamic> map) {
    super.fromMapBasic(map);
    idDictionary = map[KEY_ID_DICTIONARY];
    count = map[KEY_COUNT];
  }
}
