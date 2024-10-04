  import 'package:intl/intl.dart';

String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat.yMMMMd().format(date);
    } catch (_) {
      return dateStr;
    }
  }