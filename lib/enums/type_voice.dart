enum EnumTypeVoice { WORD, EXPLANATION }

  EnumTypeVoice getFromString(String value) {
    return EnumTypeVoice.values.firstWhere((element) {
      print('$element');
      return element.toString().split('.')[1].toUpperCase() ==
          value.toUpperCase();
    });
  }

  String getString(EnumTypeVoice enumTypeVoice) {
    return enumTypeVoice.toString().split('.')[1];
  }
