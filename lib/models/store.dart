import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/models/tag.dart';

class StoreCategory {
  final int id;
  final String name;

  StoreCategory({required this.id, required this.name});

  factory StoreCategory.fromJson(Map<String, dynamic> json) =>
      StoreCategory(id: json["id"], name: json["name"]);
}

class StoreHome {
  final String name;
  final String status;
  final String owner;
  final String category;
  final int totalMenuCnt;
  final int discountMenuCnt;
  final Tag? tag;
  final String? storePictureUrl;

  StoreHome(
      {required this.name,
      required this.status,
      required this.owner,
      required this.category,
      required this.storePictureUrl,
      required this.totalMenuCnt,
      required this.discountMenuCnt,
      required this.tag});

  factory StoreHome.fromJson(Map<String, dynamic> json) => StoreHome(
        name: json['name'],
        status: json['status'],
        owner: json['businessLeaderName'],
        category: json['category'] == null
            ? ""
            : (json['category'] as List)
                .map((e) => e['name'].toString())
                .join(", "),
        storePictureUrl: json['storePictureUrl'],
        totalMenuCnt: json['totalMenuCount'],
        discountMenuCnt: json['discountMenuCount'],
        tag: json['tag'] != null ? Tag.fromJson(json['tag']) : null,
      );
}

class StoreDetail {
  int id;
  String name;
  List<String> categories;
  String address;
  String? addressDetail;
  LatLng latLng;
  String pickUpTime;
  String openTime;
  String closeTime;
  List<Menu> menu;
  List<String> notes;
  List<Origin> origins;
  String phone;
  int cookingTime;
  /* Optional */
  String? description;
  String? imgUrl;

  StoreDetail({
    required this.id,
    required this.name,
    required this.categories,
    required this.address,
    required this.addressDetail,
    required this.latLng,
    required this.pickUpTime,
    required this.openTime,
    required this.closeTime,
    required this.menu,
    required this.notes,
    required this.origins,
    required this.phone,
    required this.cookingTime,
    this.description,
    this.imgUrl,
  });

  factory StoreDetail.fromJson(Map<dynamic, dynamic> json) {
    final origins = (json['menus'] as List)
        .expand((e) => e['countryOfOrigin'] ?? [])
        .toList()
        .map((e) => Origin.fromJson(e))
        .toList();

    return StoreDetail(
      id: json['id'],
      name: json['name'],
      categories: (json['categories'] as List)
          .map((e) => e['name'].toString())
          .toList(),
      address: json['detail']['address'],
      addressDetail: json['detail']['addressDetail'],
      latLng: LatLng(
        double.parse(json['detail']['lat']),
        double.parse(json['detail']['lon']),
      ),
      pickUpTime: json['detail']['pickUpTime'],
      openTime: json['detail']['operationTimes']['startedAt'],
      closeTime: json['detail']['operationTimes']['endedAt'],
      menu: (json['menus'] as List).map((e) => Menu.fromStoreJson(e)).toList(),
      notes: (json['caution'] as List).map((e) => e.toString()).toList(),
      origins: origins,
      phone: json['detail']['phone'],
      cookingTime: json['detail']['cookingTime'],
      /* Optional */
      description: json['detail']['description'],
      imgUrl: json['detail']['storePictureUrl'],
    );
  }
}

class StoreMenu {
  int id;
  String name;
  String address;
  LatLng latLng;
  String pickUpTime;
  String phone;

  StoreMenu({
    required this.id,
    required this.name,
    required this.address,
    required this.latLng,
    required this.pickUpTime,
    required this.phone,
  });

  factory StoreMenu.fromJson(Map<String, dynamic> json) {
    return StoreMenu(
      id: json['id'],
      name: json['name'],
      address: json['detail']['address'] +
          (json['detail']['addressDetail'] == null
              ? ""
              : " ${json['detail']['addressDetail']}"),
      latLng: LatLng(
        double.parse(json['detail']['lat']),
        double.parse(json['detail']['lon']),
      ),
      pickUpTime: json['detail']['pickUpTime'],
      phone: json['detail']['phone'],
    );
  }
}
