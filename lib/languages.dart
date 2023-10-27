import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'hello': '안녕하세요',
        },
        'en_US': {
          'hello': 'Hello',
        },
      };
}