import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage(
      {super.key,
      this.color = KwangColor.grey400,
      this.backgroundColor = Colors.transparent,
      this.hasTopPadding = false});

  final Color color;
  final Color backgroundColor;
  final bool hasTopPadding;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        padding:
            hasTopPadding ? const EdgeInsets.only(top: 64) : EdgeInsets.zero,
        color: backgroundColor,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            color: color,
          ),
        ),
      ),
    );
  }
}
