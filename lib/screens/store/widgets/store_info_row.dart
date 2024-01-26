import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class StoreInfoRow extends StatelessWidget {
  const StoreInfoRow(
      {super.key,
      required this.title,
      required this.content,
      required this.hasPaddingBottom});
  final String title;
  final String content;
  final bool hasPaddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasPaddingBottom ? 8 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 46,
            child: Text(
              title,
              style: KwangStyle.body2M.copyWith(color: KwangColor.grey600),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              content,
              style: KwangStyle.body2M,
            ),
          ),
        ],
      ),
    );
  }
}
