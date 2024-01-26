import 'package:flutter/material.dart';

class BulletString extends StatelessWidget {
  const BulletString(
      {super.key,
      required this.txt,
      required this.style,
      required this.hasBottomPadding});
  final String txt;
  final TextStyle style;
  final bool hasBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          hasBottomPadding ? const EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: style,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              txt,
              style: style.copyWith(overflow: TextOverflow.visible),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
