import 'dart:convert';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/models/tag.dart';
import 'package:kwangsaeng_seller/screens/home/home_view_model.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final _api = API();

  Future<StoreHome> getStoreInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/stores/basic/${prefs.getString("storeId")}", HttpMethod.get,
        type: UrlType.dev, needToken: true);
    
    if (res.statusCode == 200) {
      return StoreHome.fromJson(jsonDecode(res.body)["data"]);
    } else {
      throw Exception("http Exception");
    }
  }

  Future<List<Tag>> getTags() async {
    final res = await _api.req("/tags", HttpMethod.get,
        type: UrlType.dev, needToken: true);

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["data"]
          .map<Tag>((e) => Tag.fromJson(e))
          .toList();
    } else {
      throw Exception("http Exception");
    }
  }

  Future<StoreStatus> updateStoreStatus(StoreStatus status) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/stores/status/${prefs.getString("storeId")}", HttpMethod.patch,
        type: UrlType.dev, needToken: true);

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["data"]["status"] == "open"
          ? StoreStatus.open
          : StoreStatus.closed;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> updateStoreTag(int tagId) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/stores/${prefs.getString("storeId")}", HttpMethod.put,
        type: UrlType.dev, needToken: true, body: jsonEncode({"tagId": tagId}));

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }
}
