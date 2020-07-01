import 'package:kendin_ogren/database/db_helper.dart';
import 'package:kendin_ogren/model/base_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRepo<T extends BaseModel> {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      DbHelper dbHelper = DbHelper.instance;
      _db = await dbHelper.db;
    }
    return _db;
  }

  getById(int id) async {
    final dbClient = await db;
    var result = await dbClient
        .query(tableName(), where: '${BaseModel.KEY_ID} = ?', whereArgs: [id]);
    return result.isNotEmpty ? fromMap(result.first) : Null;
  }

  Future<List<T>> getListByColumn(String column, var value) async {
    final dbClient = await db;
    var result = await dbClient
        .query(tableName(), where: '$column = ?', whereArgs: [value]);
    return result.map((data) => fromMap(data)).toList();
  }

  Future<List<T>> getAll() async {
    var dbClient = await db;
    var result =
        await dbClient.query(tableName(), orderBy: BaseModel.KEY_CREATE_DATE);

    return result.map((data) => fromMap(data)).toList();
  }

  Future<int> add(T t) async {
    var dbClient = await db;
    if(t.id==0){
      t.updateDate = DateTime.now();
      t.createDate = DateTime.now();
    }
    return await dbClient.insert(tableName(), t.toMap());
  }

  update(T t) async {
    final dbClient = await db;
    if(t.id!=0){
      t.updateDate = DateTime.now();
    }
    var res = await dbClient.update(tableName(), t.toMap(),
        where: '${BaseModel.KEY_ID} =?', whereArgs: [t.id]);
    return res;
  }

  deleteTodo(int id) async {
    final dbClient = await db;
    var res = dbClient
        .delete(tableName(), where: '${BaseModel.KEY_ID} =?', whereArgs: [id]);
    return res;
  }

  deleteAllTodos() async {
    final dbClient = await db;
    dbClient.rawDelete("DELETE FROM ${tableName()}");
  }

  T fromMap(Map map);

  String tableName();
}
