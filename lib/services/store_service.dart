import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
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

  Future<bool> modifyStore(
    String storeName,
    String address,
    String phone,
    List<int> categories,
    int cookingTime,
    String openTime,
    String closeTime,
    String? storeImg, // [주의] 제거 시 상태 값 null.
    String? description, // [주의] 제거 시 상태 값 빈문자열
    String? addressDetail, // [주의] 제거 시 상태 값 빈문자열
  ) async {
    final prefs = await SharedPreferences.getInstance();
    print(jsonEncode({
      "name": storeName,
      "address": address,
      "addressDetail": addressDetail ?? "",
      "phone": phone,
      "categories": categories,
      "cookingTime": cookingTime,
      "operationTimes": {
        "startedAt": openTime,
        "endedAt": closeTime,
      },
      "storePictureUrl": storeImg,
      "description": description ?? "",
    }));

    final res =
        await _api.req("/stores/${prefs.getString("storeId")}", HttpMethod.put,
            body: jsonEncode(
              {
                "name": storeName,
                "address": address,
                "addressDetail": addressDetail ?? "",
                "phone": phone,
                "categories": categories,
                "cookingTime": cookingTime,
                "operationTimes": {
                  "startedAt": openTime,
                  "endedAt": closeTime,
                },
                "storePictureUrl": storeImg,
                "description": description ?? "",
              },
            ),
            type: UrlType.dev,
            needToken: true);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<String> uploadStoreImg(String path) async {
    var file = FormData.fromMap({
      'file': MultipartFile.fromFileSync(path,
          contentType: MediaType("image", "jpg")),
    });
    final dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final res = await dio.post(
        "${_api.devUrl}/stores/upload/${prefs.getString("storeId")}",
        data: file,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            "Authorization": "Bearer ${await _api.getAccessToken()}",
          },
        ));
    if (res.statusCode == 201) {
      return res.data["data"];
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
