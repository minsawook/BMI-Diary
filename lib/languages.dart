import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ko_KR': {
      'calculator': 'BMI 계산기',
      'graph' : '그래프',
      'diary' : "식단 다이어리",
      'settings' : '설정'
    },
    'en_US': {
      'calculator': 'BMI Calculator',
      'graph' : 'graph',
      'diary' : "diet diary",
      'settings' : 'settings'
    },
  };
}