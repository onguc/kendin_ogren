import 'package:intl/intl.dart';

abstract class BaseModel {
  static const String KEY_CREATE_DATE = "createDate";
  static const String KEY_ID= "id";
  int _id;
  DateTime _createDate;
  DateTime _updateDate;

  BaseModel.everyThings(this._id, this._createDate, this._updateDate);

  BaseModel();

  BaseModel.notUpdateDate(this._id, this._createDate);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> getMapBasic() {
    var map = Map<String, dynamic>();
//    map["_id"] = _id;
    map["createDate"] = _getDateString(createDate);
    map["updateDate"] = _getDateString(updateDate);
    return map;
  }

  fromMapBasic(Map<String, dynamic> map) {
    _id = map["id"];
    _createDate = _getDateFromString(map["createDate"]);
    _updateDate = _getDateFromString(map["updateDate"]);
  }


  Map<String, dynamic> toMap();


  BaseModel.fromMap(Map<String, dynamic> map){
    fromMapBasic(map);
  }



  DateTime get createDate {
    if (_createDate == null) _createDate = DateTime.now();
    return _createDate;
  }

  set createDate(DateTime value) {
    _createDate = value;
  }

  DateTime get updateDate {
    if (_updateDate == null) _updateDate = DateTime.now();
    return _updateDate;
  }

  set updateDate(DateTime value) {
    _updateDate = value;
  }

  String _getDateString(DateTime dateTime) {
    var format = _getFormat();
    return DateFormat(format).format(dateTime);
  }

  DateTime _getDateFromString(String dateTimeString) {
    var format = _getFormat();
    var parse = DateFormat(format).parse(dateTimeString);
    return parse;
  }

  String _getFormat() => "yyyy-MM-dd kk:mm:ss";
}
