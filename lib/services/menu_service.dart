import 'dart:convert';

import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuService {
  final _api = API();

  Future<List<Menu>> getMenus() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/menus/seller/${prefs.getString("storeId")}", HttpMethod.get,
        type: UrlType.dev, needToken: true);
    print(res.body);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)["data"] as List).map((e) => Menu.fromJson(e)).toList();
    } else {
      throw Exception("http Exception");
    }
  }
}
