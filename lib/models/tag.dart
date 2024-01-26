import 'package:flutter/material.dart';

class Tag {
  int id;
  String icon;
  String name;
  String description;
  Color txtColor;
  Color bgColor;

  Tag(
      {required this.id,
      required this.icon,
      required this.name,
      required this.description,
      required this.txtColor,
      required this.bgColor});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'],
        icon: json['name'],
        name: json['content'],
        description: json['description'],
        txtColor: Color(int.parse(json['textColor'], radix: 16)),
        bgColor: Color(int.parse(json['backgroundColor'], radix: 16)),
      );
}
