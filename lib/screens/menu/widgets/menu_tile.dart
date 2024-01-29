import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_status_widget.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

enum MenuTileType { main, changeOrder }

class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.type, required this.menu});

  final MenuTileType type;
  final Menu? menu;
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MenuTileType.main:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: KwangColor.grey100,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: const MenuStatusWidget(status: MenuStatus.sale)),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset("assets/icons/ic_24_more.svg",
                        width: 24, height: 24),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ExtendedImage.network(
                        "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEwMDNfMjcy%2FMDAxNjk2MzEyOTM0MDM5.5whMBDcDO5ucM_hmOuD_OHTXT4B_IsA7G0q_xSRrPJsg.IduJR4uLR4D9vtNcsVphThjjpvJUvCuHVouRLaOMKrgg.JPEG.msinvestment%2F%25C5%25A9%25B1%25E2%25BA%25AF%25C8%25AF23022219212.jpg&type=sc960_832",
                        width: 62,
                        height: 62,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "샐러드",
                          style: KwangStyle.body2
                              .copyWith(color: KwangColor.grey600),
                        ),
                        const SizedBox(height: 2),
                        Text("오렌치 치킨 샐러드(M)", style: KwangStyle.body1M),
                        const SizedBox(height: 4),
                        Text("정가: 9,900원", style: KwangStyle.body1M),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "판매가:",
                    style: KwangStyle.btn1SB.copyWith(color: KwangColor.red),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "7,900 원",
                      style: KwangStyle.btn1SB,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      case MenuTileType.changeOrder:
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: KwangColor.grey100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ExtendedImage.network(
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEwMDNfMjcy%2FMDAxNjk2MzEyOTM0MDM5.5whMBDcDO5ucM_hmOuD_OHTXT4B_IsA7G0q_xSRrPJsg.IduJR4uLR4D9vtNcsVphThjjpvJUvCuHVouRLaOMKrgg.JPEG.msinvestment%2F%25C5%25A9%25B1%25E2%25BA%25AF%25C8%25AF23022219212.jpg&type=sc960_832",
                      width: 62,
                      height: 62,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "샐러드",
                        style: KwangStyle.body2
                            .copyWith(color: KwangColor.grey600),
                      ),
                      const SizedBox(height: 2),
                      Text(menu!.name, style: KwangStyle.body1M),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "판매가:",
                            style: KwangStyle.btn2SB
                                .copyWith(color: KwangColor.red),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${NumberFormat('###,###,###,###').format(menu!.discountPrice).replaceAll(' ', ',')} 원",
                            style: KwangStyle.btn2SB,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/icons/ic_36_handle.svg",
                width: 36,
                height: 36,
                colorFilter:
                    const ColorFilter.mode(KwangColor.grey600, BlendMode.srcIn),
              )
            ],
          ),
        );
    }
  }
}
