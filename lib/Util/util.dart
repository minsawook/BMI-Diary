import 'package:intl/intl.dart';

class Util {
  String getDate(DateTime dataTime){
    //DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(dataTime);
    return date;
  }
}