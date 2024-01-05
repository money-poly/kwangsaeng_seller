import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/setting/widgets/setting_btn.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class SettingMainView extends StatelessWidget {
  const SettingMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "빵/샌드위치",
                      style:
                          KwangStyle.body2M.copyWith(color: KwangColor.grey600),
                    ),
                    const SizedBox(height: 2),
                    Text("파리바게트 광운대점", style: KwangStyle.header1),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: KwangColor.grey400, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text("정보 수정",
                                style: KwangStyle.body2M
                                    .copyWith(color: KwangColor.grey700)),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              "assets/icons/ic_16_edit.svg",
                              width: 16,
                              height: 16,
                              colorFilter: const ColorFilter.mode(
                                  KwangColor.grey700, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ExtendedImage.network(
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA4MjJfMzYg%2FMDAxNjI5NjMwODY0MDgy.nMnl7I1VkBWYCEb-NfOxZJNthMfaRYymBzdZYkkxDpYg.jA9ADpNPVWN7H2cM8180x_Lz8kV1XezYSqf43T3twE0g.JPEG.yscloset%2F20210818_132838.jpg",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SettingBtn(title: "비밀번호 변경", onTap: () {}),
          SettingBtn(title: "고객센터", onTap: () {}),
          SettingBtn(title: "서비스 이용약관", onTap: () {}),
        ],
      ),
    ));
  }
}
