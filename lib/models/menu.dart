import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/models/tag.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/utils.dart/menu_status_util.dart';

enum MenuStatus {
  sale("판매중", KwangColor.secondary400, "고객들에게 판매할 수 있는 상태"),
  hidden("숨김", KwangColor.grey600, "일시적으로 숨김처리되어 메뉴가 보이지 않는 상태"),
  soldout("품절", KwangColor.red, "메뉴는 노출되지만 품절 표시인 상태");

  const MenuStatus(this.str, this.color, this.description);
  final String str;
  final Color color;
  final String description;
}

// ignore: must_be_immutable
class Menu extends Equatable {
  int id;
  String name;
  int discountRate;
  int discountPrice;
  int? regularPrice;
  String? imgUrl;
  String? description;
  String? store;
  int? view;
  List<Tag>? tags;
  List<Origin>? origins;
  MenuStatus? status;

  Menu({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.discountRate,
    required this.discountPrice,
    this.regularPrice,
    this.description,
    this.store,
    this.view,
    this.tags,
    this.origins,
    this.status,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        discountRate: json['discountRate'],
        discountPrice: json['sellingPrice'],
        /* Optional */
        status: strToMenuStatus(json['status']),
        imgUrl: json['menuPictureUrl'],
        regularPrice: json['price'],
        description: json['description'],
        store: json['storeName'],
        view: json['viewCount'] ?? json['view'],
        tags: json['tags'],
        origins: json['origins'],
      );

  factory Menu.fromStoreJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        discountRate: json['discountRate'],
        discountPrice: json['salePrice'],
        /* Optional */
        imgUrl: json['menuPictureUrl'],
        regularPrice: json['price'],
        description: json['description'],
        store: json['storeName'],
        view: json['viewCount'] ?? json['view'],
        tags: json['tags'],
        origins: json['origins'],
      );

  factory Menu.fromDetailJson(Map<String, dynamic> json) => Menu(
        id: json['menuId'],
        name: json['name'],
        discountRate: json['discountRate'],
        discountPrice: json['price'],
        imgUrl: json['menuPictureUrl'],
        /* Optional */
        regularPrice: json['price'],
        description: json['description'],
        store: json['storeName'],
        view: json['viewCount'] ?? json['view'],
        tags: json['tags'],
        origins: json['origins'],
      );

  @override
  List<Object?> get props => [id];
}

class MenuDetail {
  String name;
  int discountRate;
  int discountPrice;
  int regularPrice;
  StoreMenu store;
  List<Menu> anotherMenus;
  int view;
  List<String> cautions;
  List<Origin> origins;
  /* Optional */
  String? menuPictureUrl;
  String? description;

  MenuDetail({
    required this.name,
    required this.discountRate,
    required this.discountPrice,
    required this.regularPrice,
    required this.store,
    required this.anotherMenus,
    required this.view,
    required this.origins,
    required this.cautions,
    this.menuPictureUrl,
    this.description,
  });

  factory MenuDetail.fromJson(Map<dynamic, dynamic> json) => MenuDetail(
        name: json['name'],
        discountRate: json['discountRate'],
        discountPrice: json['sellingPrice'],
        regularPrice: json['price'],
        store: StoreMenu.fromJson(json['store']),
        anotherMenus: (json['anotherMenus'] as List)
            .map((e) => Menu.fromDetailJson(e))
            .toList(),
        view: json['viewCount'],
        cautions: json['caution'].cast<String>(),
        origins: json['countryOfOrigin'] == null
            ? []
            : (json['countryOfOrigin'] as List)
                .map((e) => Origin.fromJson(e))
                .toList(),
        /* Optional */
        menuPictureUrl: json['menuPictureUrl'],
        description: json['description'],
      );
}
