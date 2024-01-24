import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: KwangStyle.header3),
    );
  }
}
