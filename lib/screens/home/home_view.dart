import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/models/tag.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/tag_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KwangColor.grey200,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/imgs/img_46_logo_appbar.png",
              width: 46,
              height: 28,
            ),
            const SizedBox(width: 8),
            Text("광생", style: KwangStyle.appBar1),
            const SizedBox(width: 4),
            Text(
              "사장님",
              style: KwangStyle.appBar2.copyWith(color: KwangColor.primary400),
            ),
          ],
        ),
        toolbarHeight: 64,
        titleSpacing: 20,
        centerTitle: false,
        backgroundColor: KwangColor.grey200,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Stack(
                children: [
                  Container(
                    height: 166,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: KwangColor.grey100,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 64,
                      width: MediaQuery.of(context).size.width - 40,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                        color: KwangColor.secondary400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("현재 영업 상태",
                              style: KwangStyle.header3
                                  .copyWith(color: KwangColor.grey100)),
                          Text(
                            "OPEN",
                            style: KwangStyle.btn1B.copyWith(
                              color: KwangColor.grey100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ExtendedImage.network(
                                  "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA4MjJfMzYg%2FMDAxNjI5NjMwODY0MDgy.nMnl7I1VkBWYCEb-NfOxZJNthMfaRYymBzdZYkkxDpYg.jA9ADpNPVWN7H2cM8180x_Lz8kV1XezYSqf43T3twE0g.JPEG.yscloset%2F20210818_132838.jpg",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("빵/샌드위치",
                                      style: KwangStyle.body2M
                                          .copyWith(color: KwangColor.grey600)),
                                  const SizedBox(height: 4),
                                  Text("파리바게트 광운대점", style: KwangStyle.btn2SB),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {},
                                    behavior: HitTestBehavior.translucent,
                                    child: Row(children: [
                                      Text(
                                        "매장 상세",
                                        style: KwangStyle.body2M.copyWith(
                                            color: KwangColor.secondary400),
                                      ),
                                      const SizedBox(width: 4),
                                      SvgPicture.asset(
                                        "assets/icons/ic_18_arrow_right.svg",
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                            KwangColor.secondary400,
                                            BlendMode.srcIn),
                                      )
                                    ]),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 32,
                            child: CupertinoSwitch(
                              value: true,
                              onChanged: (value) {
                                print(value);
                              },
                              activeColor: KwangColor.secondary400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("가게 현황", style: KwangStyle.header2),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 88,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: KwangColor.grey100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "할인 태그",
                                style: KwangStyle.btn2SB,
                              ),
                              SvgPicture.asset(
                                "assets/icons/ic_18_arrow_right.svg",
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          TagWidget(
                            tag: Tag(
                                name: "마감할인",
                                txtColor: Color(int.parse("0xFF6FC36D")),
                                bgColor: Color(int.parse("0xFFF4F6FA")),
                                icon: "alarm"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 88,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: KwangColor.grey100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "할인 메뉴",
                                style: KwangStyle.btn2SB,
                              ),
                              SvgPicture.asset(
                                "assets/icons/ic_18_arrow_right.svg",
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("8", style: KwangStyle.header0),
                              const SizedBox(width: 4),
                              Text("개 / ${20}개", style: KwangStyle.body1),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
