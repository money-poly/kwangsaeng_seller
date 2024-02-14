import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  final _api = API();
  final _tempLatLng = const LatLng(37.61977, 127.06092);

  Future<StoreDetail> getStoreDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
      "/stores/${prefs.getString("storeId")}?lat=${_tempLatLng.latitude}&lon=${_tempLatLng.longitude}",
      HttpMethod.get,
      type: UrlType.dev,
    );

    if (res.statusCode == 200) {
      return StoreDetail.fromJson(jsonDecode(res.body)["data"]);
    } else {
      throw Exception("http Exception");
    }
  }
}
