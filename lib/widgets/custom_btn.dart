import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.txt,
      required this.txtColor,
      required this.bgColor,
      required this.onTap,
      this.height = 52});
  final String txt;
  final Color txtColor;
  final Color bgColor;
  final Function() onTap;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
        ),
        child: Text(
          txt,
          style: KwangStyle.btn2B.copyWith(color: txtColor),
        ),
      ),
    );
  }
}
