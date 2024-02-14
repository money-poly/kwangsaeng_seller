class CustomException implements Exception {
  final ErrorCode errorCode;

  CustomException(this.errorCode);
}

enum ErrorCode {
  tokenExpired(4000, "토큰이 만료 되었습니다.");
  
  const ErrorCode(this.code, this.message);
  final int code;
  final String message;
}