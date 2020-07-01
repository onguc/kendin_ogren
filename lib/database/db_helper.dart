import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/model/views_count.dart';
import 'package:kendin_ogren/model/voice.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  static Database _db; //bu şekilde değişkenler _ ile başlarsa bu private olur.

  DbHelper.internal();


  static DbHelper get instance => _instance;

  Future<Database> get db async {
    // bu şekilde de getter fonksiyonu oluşmuş oluyor
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
//    Directory directory = await getApplicationDocumentsDirectory();
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "KendinOgren.db");

    var ourDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return ourDb;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    var tableNameFolder = Folder.TABLE_NAME;
    var tableNameDictionary = Dictionary.TABLE_NAME;
    var tableNameVoice = Voice.TABLE_NAME;
    var tableNameViewsCount = DictionaryViewsCount.TABLE_NAME;

    // genel bir metod bu şekilde oluyor
    await db.execute(
        "CREATE TABLE $tableNameFolder(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, createDate TEXT,updateDate TEXT)");
    await db.execute("CREATE TABLE $tableNameDictionary("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "idVoice INTEGER, "
        "idFolder INTEGER, "
        "word TEXT, explanation TEXT, "
        "createDate TEXT,updateDate TEXT, "
        "FOREIGN KEY (idFolder) REFERENCES $tableNameFolder (id) ON DELETE NO ACTION ON UPDATE NO ACTION)");

    await db.execute("CREATE TABLE $tableNameViewsCount("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "idDictionary INTEGER, "
        "count INTEGER, "
        "createDate TEXT,updateDate TEXT, "
        "FOREIGN KEY (idDictionary) REFERENCES $tableNameDictionary (id) ON DELETE NO ACTION ON UPDATE NO ACTION)");

    await db.execute("CREATE TABLE $tableNameVoice("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "idDictionary INTEGER, "
        "name TEXT, "
        "createDate TEXT,"
        "updateDate TEXT)");
//        "FOREIGN KEY (idDictionary) REFERENCES $tableNameDictionary (id) ON DELETE CASCADE ON UPDATE CASCADE)");

    print("Tables are created");

  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
