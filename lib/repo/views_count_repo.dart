import 'package:kendin_ogren/model/views_count.dart';
import 'package:kendin_ogren/repo/base_repo.dart';

class DictionaryViewsCountRepo extends BaseRepo<DictionaryViewsCount> {
//  Future<List<DictionaryViewsCount>> getDictionaryViewsCountList() async {
//    var dbClient = await db;
//    var result = await dbClient.query(DictionaryViewsCount.TABLE_NAME,
//        orderBy: BaseModel.KEY_CREATE_DATE);
//
//    return result.map((data) => DictionaryViewsCountfromMapBase(data)).toList();
//  }
//
//  Future<int> add(DictionaryViewsCount dictionaryViewsCount) async {
//    var dbClient = await db;
//    return await dbClient.insert(
//        DictionaryViewsCount.TABLE_NAME, dictionaryViewsCount.toMap());
//  }

  Future<List<DictionaryViewsCount>> getListByDictionary(int idDictionary) {
    var listByColumn =
        getListByColumn(DictionaryViewsCount.KEY_ID_DICTIONARY, idDictionary);
    return listByColumn;
  }

  @override
  String tableName() {
    return DictionaryViewsCount.TABLE_NAME;
  }

  @override
  DictionaryViewsCount fromMap(Map map) {
    var dictionaryViewsCount = DictionaryViewsCount.fromMap(map);
    return dictionaryViewsCount;
  }
}
