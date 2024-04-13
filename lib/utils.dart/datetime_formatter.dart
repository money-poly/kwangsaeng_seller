enum DateTimStrType {
  korean,
}

String dateToStr(DateTimStrType type, DateTime dateTime) {
  switch (type) {
    case DateTimStrType.korean:
      return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일';
  }
}
