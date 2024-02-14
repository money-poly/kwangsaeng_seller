import 'package:flutter/material.dart';

class Tag {
  int id;
  String name;
  String description;
  String icon;
  String content;
  Color txtColor;
  Color bgColor;

  Tag(
      {required this.id,
      required this.name,
      required this.description,
      required this.icon,
      required this.content,
      required this.txtColor,
      required this.bgColor});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        icon: json['icon'],
        content: json['content'],
        txtColor: Color(int.parse(json['textColor'], radix: 16)),
        bgColor: Color(int.parse(json['backgroundColor'], radix: 16)),
      );
}
