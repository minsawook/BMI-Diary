import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ko_KR': {
      'calculator': '계산기',
      'chart' : '통계',
      'diet_record' : "식단 기록",
      'settings' : '설정'
    },
    'en_US': {
      'calculator': 'calculator',
      'chart' : 'chart',
      'diet_record' : "Diet record",
      'settings' : 'settings'
    },
  };
}