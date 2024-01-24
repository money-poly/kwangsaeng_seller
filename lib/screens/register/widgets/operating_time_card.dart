import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class OperatingTimeCard extends StatelessWidget {
  const OperatingTimeCard(
      {super.key,
      required this.title,
      required this.time,
      required this.isSelected});

  final String title;
  final String time;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: (MediaQuery.of(context).size.width - 60) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? KwangColor.secondary400 : KwangColor.grey300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: KwangStyle.body3.copyWith(
                color: isSelected ? KwangColor.grey100 : KwangColor.grey600),
          ),
          Text(
            time,
            style: KwangStyle.btn1SB.copyWith(
                color: isSelected ? KwangColor.grey100 : KwangColor.grey600),
          ),
        ],
      ),
    );
  }
}
