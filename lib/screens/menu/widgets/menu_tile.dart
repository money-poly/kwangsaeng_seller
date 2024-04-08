import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_main_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_bottom_sheet.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_status_widget.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:provider/provider.dart';

enum MenuTileType { main, changeOrder }

class MenuTile extends StatelessWidget {
  const MenuTile(
      {super.key,
      required this.type,
      required this.menu,
      required this.idx,
      this.viewModel});

  final MenuTileType type;
  final Menu? menu;
  final int idx;
  final MenuMainViewModel? viewModel;
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ChangeNotifierProvider.value(
                            value: viewModel,
                            child: MenuBottomSheet(
                                type: MenuBottomSheetType.status, menuIdx: idx),
                          ),
                        );
                      },
                      child: MenuStatusWidget(status: menu!.status)),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ChangeNotifierProvider.value(
                          value: viewModel,
                          child: MenuBottomSheet(
                              type: MenuBottomSheetType.more, menuIdx: idx),
                        ),
                      );
                    },
                    child: SvgPicture.asset("assets/icons/ic_24_more.svg",
                        width: 24, height: 24),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    menu!.imgUrl == null
                        ? Container(
                            height: 62,
                            width: 62,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: KwangColor.grey200,
                              border: Border.all(
                                  color: KwangColor.grey400, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "사진을\n올려보세요!",
                              style: KwangStyle.body3M
                                  .copyWith(color: KwangColor.grey700),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: ExtendedImage.network(
                              menu!.imgUrl!,
                              width: 62,
                              height: 62,
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // [TODO] 카테고리가 제외되면서 임시 삭제. 추후 메뉴 카테고리 결정되면 주석 해제
                        // Text(
                        //   "샐러드",
                        //   style: KwangStyle.body2
                        //       .copyWith(color: KwangColor.grey600),
                        // ),
                        // const SizedBox(height: 2),
                        Text(menu!.name, style: KwangStyle.body1M),
                        const SizedBox(height: 4),
                        Text(
                            "정가: ${NumberFormat('###,###,###,###').format(menu!.regularPrice).replaceAll(' ', ',')}원",
                            style: KwangStyle.body1M),
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
                      "${NumberFormat('###,###,###,###').format(menu!.discountPrice).replaceAll(' ', ',')} 원",
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
                  menu!.imgUrl == null
                      ? Container(
                          height: 62,
                          width: 62,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: KwangColor.grey200,
                            border:
                                Border.all(color: KwangColor.grey400, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "사진을\n올려보세요!",
                            style: KwangStyle.body3M
                                .copyWith(color: KwangColor.grey700),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ExtendedImage.network(
                            menu!.imgUrl!,
                            width: 62,
                            height: 62,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // [TODO] 카테고리가 제외되면서 임시 삭제. 추후 메뉴 카테고리 결정되면 주석 해제
                      // Text(
                      //   "샐러드",
                      //   style: KwangStyle.body2
                      //       .copyWith(color: KwangColor.grey600),
                      // ),
                      // const SizedBox(height: 2),
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
