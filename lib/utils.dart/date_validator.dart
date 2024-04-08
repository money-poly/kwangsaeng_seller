DateTime? dateValidator(String input) {
  DateTime? parsedDate = DateTime.tryParse(input);
  if (parsedDate == null) {
    return null;
  } else {
    Map<int, int> daysInMonth = {
      1: 31,
      2: 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31
    };

    var year = int.parse(input.substring(0, 4));
    var month = int.parse(input.substring(4, 6));
    var day = int.parse(input.substring(6, 8));
    bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) {
      daysInMonth[2] = 29;
    }

    if (year < 1000 ||
        year > 9999 ||
        month < 1 ||
        month > 12 ||
        day > daysInMonth[month]!) {
      return null;
    } else {
      return parsedDate;
    }
  }
}
