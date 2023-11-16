import 'package:intl/intl.dart';

class Util {
  String getDate(DateTime dataTime){
    //DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(dataTime);
    return date;
  }

  int calculateWeeksInMonth(DateTime dateTime) {
    int firstDayOfMonth = DateTime(dateTime.year, dateTime.month, 1).weekday;
    int daysInMonth = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    int remainingDays = daysInMonth - (7 - firstDayOfMonth + 1);
    int weeksInMonth = 1 + (remainingDays / 7).ceil();
    return weeksInMonth;
  }
}