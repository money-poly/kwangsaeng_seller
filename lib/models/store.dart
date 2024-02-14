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
        category: json['category'],
        storePictureUrl: json['storePictureUrl'],
        totalMenuCnt: int.parse(json['totalMenuCount']),
        discountMenuCnt: int.parse(json['discountMenuCount']),
        tag: json['tag'] != null ? Tag.fromJson(json['tag']) : null,
      );
}

class StoreDetail {
  int id;
  String name;
  List<String> categories;
  String address; // address + addressDetail
  LatLng latLng;
  String pickUpTime;
  String openTime;
  String closeTime;
  List<Menu> menu;
  List<String> notes;
  List<Origin> origins;
  /* Optional */
  String? phone;
  String? imgUrl;

  StoreDetail({
    required this.id,
    required this.name,
    required this.categories,
    required this.address,
    required this.latLng,
    required this.pickUpTime,
    required this.openTime,
    required this.closeTime,
    required this.menu,
    required this.notes,
    required this.origins,
    this.phone,
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
      categories:
          (json['categories'] as List).map((e) => e.toString()).toList(),
      address: json['detail']['address'] +
          " " +
          (json['detail']['addressDetail'] ?? ""),
      latLng: LatLng(
        double.parse(json['detail']['lat']),
        double.parse(json['detail']['lon']),
      ),
      pickUpTime: json['detail']['pickupTime'],
      openTime: json['detail']['operationTimes']['startedAt'],
      closeTime: json['detail']['operationTimes']['endedAt'],
      menu: (json['menus'] as List).map((e) => Menu.fromStoreJson(e)).toList(),
      notes: (json['caution'] as List).map((e) => e.toString()).toList(),
      origins: origins,
      /* Optional */
      phone: json['phone'],
      imgUrl: json['storePictureUrl'],
    );
  }
}
