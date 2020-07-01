import 'package:kendin_ogren/database/db_helper.dart';
import 'package:kendin_ogren/model/base_model.dart';
import 'package:kendin_ogren/model/folder.dart';
import 'package:kendin_ogren/repo/base_repo.dart';
import 'package:sqflite/sqflite.dart';

class FolderRepo extends BaseRepo<Folder> {
  @override
  String tableName() {
    return Folder.TABLE_NAME;
  }

  @override
  Folder fromMap(Map map) {
    var folder = Folder.fromMap(map);
    return folder;
  }
}
