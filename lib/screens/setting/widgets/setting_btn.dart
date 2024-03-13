import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn(
      {super.key, required this.title, required this.onTap, this.icon = true});

  final String title;
  final void Function() onTap;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: KwangStyle.header3),
            if (icon)
              SvgPicture.asset(
                "assets/icons/ic_18_arrow_right.svg",
                width: 18,
                height: 18,
                colorFilter:
                    const ColorFilter.mode(KwangColor.grey600, BlendMode.srcIn),
              )
          ],
        ),
      ),
    );
  }
}
