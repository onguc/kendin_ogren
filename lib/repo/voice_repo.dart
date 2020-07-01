import 'package:kendin_ogren/model/voice.dart';
import 'package:kendin_ogren/repo/base_repo.dart';

class VoiceRepo extends BaseRepo<Voice> {
  @override
  Voice fromMap(Map map) {
    var voice = Voice.fromMap(map);
    return voice;
  }

  @override
  String tableName() {
    return Voice.TABLE_NAME;
  }
}
