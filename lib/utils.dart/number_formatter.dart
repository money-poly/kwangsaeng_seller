import 'package:intl/intl.dart';

String kmNumberFormatter(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    return '${NumberFormat.compact().format(number / 1000)}K';
  } else {
    return '${NumberFormat.compact().format(number / 1000000)}M';
  }
}
