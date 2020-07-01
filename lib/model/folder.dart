import 'package:kendin_ogren/model/base_model.dart';

class Folder extends BaseModel {
  static const String TABLE_NAME = "FOLDER";

  Folder();

  String _name;

  set name(String value) {
    _name = value;
  }

  get name => _name;


  @override
  String toString() {
    return toMap().toString();
  }

  @override
  Folder.fromMap(Map<String, dynamic> map) {
    super.fromMapBasic(map);
    _name = map["name"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = super.getMapBasic();
    map["name"] = _name;
    return map;
  }
}
