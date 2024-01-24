String phoneFormatter(String phone) {
  if (phone.length == 7) {
    return "${phone.substring(0, 3)}-${phone.substring(3, 8)}";
  } else if (phone.length == 8) {
    return "${phone.substring(0, 4)}-${phone.substring(4, 8)}";
  } else {
    return phone;
  }
}
