import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onCanceled,
      required this.onConfirmed});

  final String title;
  final String content;
  final Function() onCanceled;
  final Function() onConfirmed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: KwangColor.grey100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/icons/ic_36_exclamation.svg",
              width: 36,
              height: 36,
              colorFilter:
                  const ColorFilter.mode(KwangColor.grey600, BlendMode.srcIn),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                title,
                style: KwangStyle.header1.copyWith(
                  color: KwangColor.grey900,
                ),
              ),
            ),
            Text(
              content,
              style: KwangStyle.body1M.copyWith(color: KwangColor.grey800),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onCanceled,
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: KwangColor.secondary100,
                        ),
                        child: Text(
                          "취소",
                          style: KwangStyle.btn2B
                              .copyWith(color: KwangColor.secondary400),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirmed,
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: KwangColor.secondary400,
                        ),
                        child: Text(
                          "확인",
                          style: KwangStyle.btn2B
                              .copyWith(color: KwangColor.grey100),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
