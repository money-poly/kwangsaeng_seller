import 'package:flutter/material.dart';

class Tag {
  String icon;
  String name;
  Color txtColor;
  Color bgColor;

  Tag(
      {required this.name,
      required this.txtColor,
      required this.bgColor,
      this.icon = "time"});
}