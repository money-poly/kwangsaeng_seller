import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/models/tag.dart';
import 'package:kwangsaeng_seller/styles/color.dart';

enum MenuStatus {
  sale("판매중", KwangColor.secondary400),
  hidden("숨김", KwangColor.grey400),
  soldout("품절", KwangColor.red);

  const MenuStatus(this.str, this.color);
  final String str;
  final Color color;
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
        id: json['menuId'],
        name: json['menuName'],
        discountRate: json['discountRate'],
        discountPrice: json['sellingPrice'],
        imgUrl: json['menuPictureUrl'],
        /* Optional */
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
