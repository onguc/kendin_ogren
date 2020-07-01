import 'package:kendin_ogren/enums/type_voice.dart';
import 'package:kendin_ogren/model/base_model.dart';

class Voice extends BaseModel {
  static const String TABLE_NAME = "VOICE";
  static const String ID_DICTIONARY = "idDictionary";
  static const String NAME = "name";
  static const String TYPE_VOICE = "taypeVoice";

  Voice();

  String _name;
  int _idDictionary;
  EnumTypeVoice _typeVoice=EnumTypeVoice.WORD;

  EnumTypeVoice get typeVoice => _typeVoice;

  set typeVoice(EnumTypeVoice value) {
    _typeVoice = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toMap() {
    var map = super.getMapBasic();
    map[NAME] = _name;
    map[ID_DICTIONARY] = _idDictionary;

    map[TYPE_VOICE] = getString(_typeVoice);
    return map;
  }

  Voice.fromMap(Map<String, dynamic> map) {
    _name = map[NAME];
    _idDictionary = map[ID_DICTIONARY];
    _typeVoice = getFromString(map[TYPE_VOICE]);
  }

  int get idDictionary => _idDictionary;

  set idDictionary(int value) {
    _idDictionary = value;
  }
}

