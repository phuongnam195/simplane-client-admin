import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss dd/MM/yyyy').format(dateTime);
  }

  static String formatDateTimeWOSec(DateTime dateTime) {
    return DateFormat('hh:mm dd/MM/yyyy').format(dateTime);
  }

  // duration's unit = seconds
  static String formatDuration(int duration) {
    final time = DateTime(2001, 5, 19, 0, 0, duration);
    String res = '';
    if (time.hour != 0) res += '${time.hour}h';
    if (time.minute != 0) res += ' ${time.minute}m';
    if (time.second != 0) res += ' ${time.second}s';
    return res.trim();
    // if (duration < 60) {
    //   return '${duration}s';
    // } else if (duration < 60 * 60) {
    //   String res = '${duration / 60}m';
    //   if (duration % 60 != 0) {
    //     res += ' ${duration % 60}s';
    //   }
    //   return res;
    // } else if (duration < 24 * 60 * 60) {
    //   String res = '${duration / 60 / 60}h';
    //   if (((duration / 60) % 60) != 0) {
    //     res += ' ${duration % 60}s';
    //   }
    // }
  }
}
