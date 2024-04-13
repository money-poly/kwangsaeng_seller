import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class MenuTileBtn extends StatelessWidget {
  const MenuTileBtn(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      required this.enable});
  final String icon;
  final String label;
  final void Function() onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : () {},
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/ic_16_$icon.svg",
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                  enable ? KwangColor.secondary400 : KwangColor.grey500,
                  BlendMode.srcIn),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: KwangStyle.body1.copyWith(
                color: enable ? KwangColor.black : KwangColor.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
