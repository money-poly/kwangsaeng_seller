import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class StoreInfoRow extends StatelessWidget {
  const StoreInfoRow(
      {super.key,
      required this.title,
      required this.content,
      required this.hasPaddingBottom,
      this.selectable = false});
  final String title;
  final String content;
  final bool hasPaddingBottom;
  final bool selectable;

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
          selectable
              ? GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: content));
                    showToast("복사가 완료되었습니다!");
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Text(content, style: KwangStyle.body2M),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        "assets/icons/ic_16_copy.svg",
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                            KwangColor.grey700, BlendMode.srcIn),
                      ),
                    ],
                  ),
                )
              : Expanded(
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
