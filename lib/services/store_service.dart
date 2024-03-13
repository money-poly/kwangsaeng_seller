import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  final _api = API();
  final _tempLatLng = const LatLng(37.61977, 127.06092);

  Future<bool> registerStore(
      String name,
      String storeName,
      String address,
      String businessNumber,
      String phone,
      List<int> categories,
      int cookingTime,
      String openTime,
      String closeTime,
      {String? addressDetail}) async {
    final res = await _api.req("/stores", HttpMethod.post,
        body: jsonEncode(
          {
            "businessLeaderName": name,
            "name": storeName,
            "address": address,
            if (addressDetail != null) "addressDetail": addressDetail,
            "phone": phone,
            "businessNum": businessNumber,
            "categories": categories,
            "cookingTime": cookingTime,
            "operationTimes": {
              "startedAt": openTime,
              "endedAt": closeTime,
            }
          },
        ),
        type: UrlType.dev,
        needToken: true);
    if (res.statusCode == 201) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

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
