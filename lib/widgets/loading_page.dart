import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AbsorbPointer(
      absorbing: true,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: KwangColor.secondary100,
        ),
      ),
    );
  }
}
