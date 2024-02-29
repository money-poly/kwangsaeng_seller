import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, this.color = KwangColor.grey400});

  final Color color;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: color,
        ),
      ),
    );
  }
}
