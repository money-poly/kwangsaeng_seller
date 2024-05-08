import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class MenuService {
  final _api = API();
  final _tempLatLng = const LatLng(37.61977, 127.06092);

  Future<List<Menu>> getMenus() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/menus/seller/${prefs.getString("storeId")}", HttpMethod.get,
        type: UrlType.dev, needToken: true);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body)["data"] as List)
          .map((e) => Menu.fromJson(e))
          .toList();
    } else {
      throw Exception("[${res.statusCode}]${jsonDecode(res.body)["message"]}");
    }
  }

  Future<MenuDetail> getMenuDetail(int id) async {
    final res = await _api.req(
        "/menus/detail/$id?lat=${_tempLatLng.latitude}&lon=${_tempLatLng.longitude}",
        HttpMethod.get,
        type: UrlType.dev);
    if (res.statusCode != 200) {
      throw Exception("Failed to load detail menu");
    } else {
      return MenuDetail.fromJson(jsonDecode(res.body)["data"]);
    }
  }

  Future<bool> registerMenu(
      String name,
      String description,
      int regularPrice,
      int discountPrice,
      int discountRate,
      List<Origin> origins,
      String expiredDate,
      String? imgUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req("/menus", HttpMethod.post,
        body: jsonEncode({
          "storeId": int.parse(prefs.getString("storeId")!),
          "menuPictureUrl": imgUrl,
          // category, // [TODO] 메뉴 카테고리 추가
          "name": name,
          "status": "sale",
          "price": regularPrice,
          "sellingPrice": discountPrice,
          "discountRate": discountRate,
          "description": description,
          "expiredDate": expiredDate,
          /* Optional */
          "countryOfOrigin": origins.map((e) => e.toJson()).toList(),
        }),
        type: UrlType.dev,
        needToken: true);

    if (res.statusCode == 201 || res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> modifyMenu(
      int menuId,
      String name,
      String description,
      int regularPrice,
      int discountPrice,
      int discountRate,
      List<Origin> origins,
      String expiredDate,
      String? imgUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await _api.req("/menus/$menuId", HttpMethod.put,
        body: jsonEncode({
          "storeId": int.parse(prefs.getString("storeId")!),
          "menuPictureUrl": imgUrl,
          // category, // [TODO] 메뉴 카테고리 추가
          "name": name,
          "status": "sale",
          "price": regularPrice,
          "sellingPrice": discountPrice,
          "discountRate": discountRate,
          "description": description,
          "expiredDate": expiredDate,
          /* Optional */
          "countryOfOrigin": origins.map((e) => e.toJson()).toList(),
        }),
        type: UrlType.dev,
        needToken: true);
    if (res.statusCode == 201 || res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<String> uploadMenuImg(String path) async {
    var file = FormData.fromMap({
      'file': MultipartFile.fromFileSync(path,
          contentType: MediaType("image", "jpg")),
    });
    final dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final res = await dio.post(
        "${_api.devUrl}/menus/upload/${prefs.getString("storeId")}",
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

  Future<bool> changeMenuStatus(
      int menuId, MenuStatus prevStatus, MenuStatus updateStatus) async {
    final res = await _api.req("/menus/status/$menuId", HttpMethod.put,
        body: jsonEncode({
          "prevStatus": prevStatus.name,
          "updateStatus": updateStatus.name,
        }),
        type: UrlType.dev,
        needToken: true);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteMenu(int menuId) async {
    final res = await _api.req("/menus/$menuId", HttpMethod.delete,
        type: UrlType.dev, needToken: true);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateMenuOrder(List<int> menuIds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
        "/menus/order/${prefs.getString("storeId")}", HttpMethod.put,
        type: UrlType.dev, needToken: true);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
