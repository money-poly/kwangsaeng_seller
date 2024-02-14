import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkValidToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final api = API();

  final accessToken = prefs.getString("accessToken");
  final refreshToken = prefs.getString("refreshToken");
  final accessTokenExp = prefs.getString("accessTokenExp") != null
      ? DateTime.parse(prefs.getString("accessTokenExp")!)
      : null;
  final refreshTokenExp = prefs.getString("refreshTokenExp") != null
      ? DateTime.parse(prefs.getString("refreshTokenExp")!)
      : null;
  final storeId = prefs.getString("storeId");

  print(
      "[LOG] accessToken: $accessToken / refreshToken: $refreshToken / accessTokenExp: $accessTokenExp / refreshTokenExp: $refreshTokenExp / storeId: $storeId");

  if (accessToken == null ||
      refreshToken == null ||
      accessTokenExp == null ||
      refreshTokenExp == null ||
      storeId == null) {
    return false;
  } else {
    if (accessTokenExp.isBefore(DateTime.now()) ||
        refreshTokenExp.isBefore(DateTime.now())) {
      try {
        await api.refreshToken();
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return true;
    }
  }
}
