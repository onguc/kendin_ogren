import 'dart:async';
import 'dart:io';

import 'package:flutter_sound_lite/flauto.dart';
import 'package:flutter_sound_lite/flutter_sound_player.dart';
import 'package:flutter_sound_lite/flutter_sound_recorder.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SoundTranslate {
  FlutterSoundRecorder flutterSoundRecorder;
  FlutterSoundPlayer flutterSoundPlayer;
  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;
  t_CODEC _codec = t_CODEC.CODEC_AAC;

  bool _isAudioPlayer = false;

  initRecorder() async {
    flutterSoundRecorder = await new FlutterSoundRecorder().initialize();
  }

  initPlayer() async {
    flutterSoundPlayer = await FlutterSoundPlayer().initialize();
  }

  String getFileName() {
    List<String> extension = [
      'aac', // DEFAULT
      'aac', // CODEC_AAC
      'opus', // CODEC_OPUS
      'caf', // CODEC_CAF_OPUS
      'mp3', // CODEC_MP3
      'ogg', // CODEC_VORBIS
      'pcm', // CODEC_PCM
    ];

    String dateFormat = DateFormat('yyyyMMdd_mmssSS').format(DateTime.now());
    return dateFormat + "." + extension[_codec.index];
  }

  Future<String> startRecorder() async {
    initRecorder();
    Directory tempDir = await getTemporaryDirectory();
    String fileName = getFileName();
    String pathRecorder = "${tempDir.path}/$fileName";

    String path = await flutterSoundRecorder.startRecorder(
        uri: pathRecorder, codec: _codec);
    print('startRecorder: $path');

    _recorderSubscription =
        flutterSoundRecorder.onRecorderStateChanged.listen((e) {
      DateTime date =
          new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      String txt = DateFormat('yyyy.MM.dd_mm:ss:SS').format(date);
//          print("date = " + txt);
    });

    return path;
  }

  stopRecorder() async {
    if (flutterSoundRecorder != null) {
      String result = await flutterSoundRecorder.stopRecorder();
      print('stopRecorder: $result');
      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
    }
  }

  releaseRecorder() {
    try {
      if (flutterSoundRecorder != null) {
        flutterSoundRecorder.release();
        flutterSoundRecorder = null;
      }
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }

  startPlay(String path, int position, var isFinished) async {
    if (_isAudioPlayer) {
      return;
    }
    _isAudioPlayer = true;
    initPlayer();
//    path = "/2020.05.16_06:36:158";
//    Uint8List buffer = (await rootBundle.load('samples/audio.mp3')).buffer.asUint8List();
    var isFileExist = await fileExists(path);
    if (isFileExist) {
//      TrackPlayer trackPlayer = flutterSoundPlayer as TrackPlayer;
//      Uint8List buffer = (await rootBundle.load(path)).buffer.asUint8List();

      try {
        if (flutterSoundPlayer == null)
          flutterSoundPlayer = await FlutterSoundPlayer().initialize();

        String result = await flutterSoundPlayer.startPlayer(
          path,
          codec: _codec,
          whenFinished: () {
            _isAudioPlayer = false;
            isFinished(position);
            print('I hope you enjoyed listening to this song');
          },
        );
        print('result = $result');
      } catch (e) {
        print(e);
      }
    }
  }

  stopPlayer() async {
    if (flutterSoundPlayer == null) return null;
    String result = await flutterSoundPlayer.stopPlayer();
    print('stopPlayer: $result');
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  releasePlayer() {
    flutterSoundPlayer.release();
  }

  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }
}
