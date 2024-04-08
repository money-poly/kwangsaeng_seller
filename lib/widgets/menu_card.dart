import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_status_widget.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/number_formatter.dart';

enum MenuCardType {
  vertical,
  horizontal,
}

class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.menu, required this.type});
  final Menu menu;
  final MenuCardType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MenuCardType.horizontal:
        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 132,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (menu.status == MenuStatus.soldout)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: MenuStatusWidget(
                                  status: menu.status, isSelectable: false),
                            ),
                          Flexible(
                            child: Text(
                              menu.name,
                              style: KwangStyle.body1M,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                      if (menu.description != null &&
                          menu.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            menu.description!,
                            maxLines: 2,
                            style: KwangStyle.body2M
                                .copyWith(color: KwangColor.grey600),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 4,
                        children: [
                          if (menu.discountRate != 0)
                            Text(
                              "${menu.discountRate}%",
                              style: KwangStyle.btn2B.copyWith(
                                  color: menu.status == MenuStatus.soldout
                                      ? KwangColor.grey600
                                      : KwangColor.red),
                            ),
                          Text(
                              "${NumberFormat('###,###,###,###').format(menu.discountPrice).replaceAll(' ', ',')}원",
                              style: KwangStyle.btn2B),
                        ],
                      )
                    ],
                  )),
              const SizedBox(width: 12),
              menu.imgUrl != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ExtendedImage.network(
                            menu.imgUrl!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: KwangColor.grey300, width: 1),
                            borderRadius: BorderRadius.circular(4),
                            color: menu.status == MenuStatus.soldout
                                ? KwangColor.black.withOpacity(0.4)
                                : Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: menu.status == MenuStatus.soldout
                              ? Text(
                                  menu.status.str,
                                  style: KwangStyle.body1M.copyWith(
                                    color: KwangColor.grey100,
                                  ),
                                )
                              : null,
                        )
                      ],
                    )
                  : const SizedBox(height: 80, width: 80)
            ],
          ),
        );
      case MenuCardType.vertical:
        return Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  decoration: BoxDecoration(
                      border: Border.all(color: KwangColor.grey300, width: 1),
                      borderRadius: BorderRadius.circular(4),
                      color: KwangColor.grey200),
                  child: menu.imgUrl == null
                      ? Center(
                          child: Text(
                            "이미지 준비중입니다",
                            style: KwangStyle.btn3
                                .copyWith(color: KwangColor.grey500),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ExtendedImage.network(
                            menu.imgUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: KwangColor.grey100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_24_view.svg",
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              KwangColor.grey900, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          kmNumberFormatter(menu.view!),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: KwangColor.grey900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.store!,
                    style:
                        KwangStyle.body2M.copyWith(color: KwangColor.grey600),
                  ),
                  Text(
                    menu.name,
                    style: KwangStyle.body1M
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    children: [
                      if (menu.discountRate != 0)
                        Text(
                          "${menu.discountRate}%",
                          style:
                              KwangStyle.btn2B.copyWith(color: KwangColor.red),
                        ),
                      Text(
                        "${NumberFormat('###,###,###,###').format(menu.discountPrice).replaceAll(' ', ',')}원",
                        style: KwangStyle.btn2B,
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Wrap(
            //   children: menu.tags!.map((e) => TagWidget(tag: e)).toList(),
            // )
          ],
        );
      default:
        return Container();
    }
  }
}
