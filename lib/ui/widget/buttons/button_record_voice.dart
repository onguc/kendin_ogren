import 'package:flutter/material.dart';
import 'package:kendin_ogren/constants/constants.dart';
import 'package:kendin_ogren/ui/service/sound_translate.dart';
import 'package:kendin_ogren/utils/PermitionUtils.dart';

class ButtonRecordVoice extends StatefulWidget {
  String pathVoice;
  bool isRecorded;

  ButtonRecordVoice({Key key, this.isRecorded = false, this.pathVoice=""}) : super(key: key);

  @override
  _ButtonRecordVoiceState createState() => _ButtonRecordVoiceState();
}

class _ButtonRecordVoiceState extends State<ButtonRecordVoice> {
  final Color bgColorPassive = Colors.transparent;
  final Color bgColorActive = Colors.green;

  SoundTranslate soundTranslate;

  Color colorBacground;

  Icon iconDone;

  double iconSize;

  @override
  void initState() {
    soundTranslate = SoundTranslate();
    if (widget.isRecorded)
      iconDone = iconRecorded;
    else
      iconDone = Icon(Icons.done, color: kLightBlackColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 94,
          width: 94,
          decoration: BoxDecoration(shape: BoxShape.circle, color: colorBacground),
          child: GestureDetector(
            onLongPressStart: (details) {
              setState(() {
                colorBacground = bgColorActive;
              });
              _startAudioRecorder();
            },
            onLongPressEnd: (dedails) {
              setState(() {
                colorBacground = bgColorPassive;
                iconDone = iconRecorded;
              });
              soundTranslate.stopRecorder();
            },
            child: Icon(
              Icons.keyboard_voice,
              color: Colors.pink,
              size: iconSize,
            ),
          ),
        ),
        Positioned(bottom: 0, right: 35, child: iconDone)
      ],
    );
  }

  Future<void> _startAudioRecorder() async {
    var bool = await requestPermission();
    if (bool && soundTranslate != null) {
      widget.pathVoice = await soundTranslate.startRecorder();
      int x = 0;
    }
  }

  @override
  void dispose() {
    if (soundTranslate != null) soundTranslate.releaseRecorder();
    super.dispose();
  }
}
