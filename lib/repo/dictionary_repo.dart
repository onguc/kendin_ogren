import 'package:kendin_ogren/enums/type_voice.dart';
import 'package:kendin_ogren/model/dictionary.dart';
import 'package:kendin_ogren/model/views_count.dart';
import 'package:kendin_ogren/model/voice.dart';
import 'package:kendin_ogren/repo/base_repo.dart';
import 'package:kendin_ogren/repo/views_count_repo.dart';
import 'package:kendin_ogren/repo/voice_repo.dart';

class DictionaryRepo extends BaseRepo<Dictionary> {
  DictionaryRepo() {}

  @override
  Future<List<Dictionary>> getAll() {
    DictionaryViewsCountRepo viewsCountRepo = DictionaryViewsCountRepo();
    var all = super.getAll();
    all.then((values) {
      List<DictionaryViewsCount> counts = List();
      for (var item in values) {
        var listByDictionary = viewsCountRepo.getListByDictionary(item.id);
        listByDictionary.then((value) {
          value != null && value.length > 0
              ? item.viewsCounts = value
              : item.viewsCounts = List();

          var listByColumn =
              VoiceRepo().getListByColumn(Voice.ID_DICTIONARY, item.id);
          listByColumn.then((values) {
            values.forEach((voice) {
              if (voice.typeVoice == EnumTypeVoice.WORD) {
                item.voiceWord = voice;
              } else if (voice.typeVoice == EnumTypeVoice.EXPLANATION) {
                item.voiceExplanation = voice;
              }
            });
          });
        });
      }
    });
    return all;
  }

  @override
  Dictionary fromMap(Map map) {
    var dictionary = Dictionary.fromMap(map);
    return dictionary;
  }

  @override
  String tableName() {
    return Dictionary.TABLE_NAME;
  }
}
