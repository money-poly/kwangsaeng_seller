import 'package:kwangsaeng_seller/models/tag.dart';

class StoreCategory {
  final int id;
  final String name;

  StoreCategory({required this.id, required this.name});

  factory StoreCategory.fromJson(Map<String, dynamic> json) =>
      StoreCategory(id: json["id"], name: json["name"]);
}

class HomeStore {
  final String name;
  final String status;
  final String owner;
  final String category;
  final int totalMenuCnt;
  final int discountMenuCnt;
  final Tag? tag;
  final String? storePictureUrl;

  HomeStore(
      {required this.name,
      required this.status,
      required this.owner,
      required this.category,
      required this.storePictureUrl,
      required this.totalMenuCnt,
      required this.discountMenuCnt,
      required this.tag});

  factory HomeStore.fromJson(Map<String, dynamic> json) => HomeStore(
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
