import 'package:flutter/material.dart';

enum TimeFormat {
  timeToKorStr,
  timeTo24Str,
}

String timeFormatter(TimeOfDay time, TimeFormat format) {
  switch (format) {
    case TimeFormat.timeToKorStr:
      return "${time.period.name == "am" ? "오전" : "오후"} ${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')}";
    case TimeFormat.timeTo24Str:
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}

TimeOfDay timeParser(String timeStr) {
  final time = timeStr.split(":");
  return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
}
