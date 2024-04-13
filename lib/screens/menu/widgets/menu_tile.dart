import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_detail_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_detail_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_main_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_bottom_sheet.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_status_widget.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_tile_btn.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_dialog.dart';
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
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menu!.imgUrl == null
                        ? Container(
                            width: 70,
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
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
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
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ChangeNotifierProvider.value(
                              value: viewModel,
                              child: MenuBottomSheet(
                                  type: MenuBottomSheetType.status,
                                  menuIdx: idx),
                            ),
                          );
                        },
                        child: MenuStatusWidget(status: menu!.status)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "판매가:",
                            style: KwangStyle.btn1SB.copyWith(
                              color: menu!.status == MenuStatus.sale
                                  ? KwangColor.red
                                  : KwangColor.grey500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "${NumberFormat('###,###,###,###').format(menu!.discountPrice).replaceAll(' ', ',')} 원",
                            style: KwangStyle.btn1SB.copyWith(
                              color: menu!.status == MenuStatus.sale
                                  ? KwangColor.black
                                  : KwangColor.grey500,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (menu!.status == MenuStatus.sale)
                      SizedBox(
                        width: 95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              behavior: HitTestBehavior.translucent,
                              child: SvgPicture.asset(
                                  "assets/icons/ic_24_minus.svg",
                                  width: 24,
                                  height: 24),
                            ),
                            Text(
                              "1",
                              style: KwangStyle.btn1SB,
                            ),
                            GestureDetector(
                              onTap: () {},
                              behavior: HitTestBehavior.translucent,
                              child: SvgPicture.asset(
                                  "assets/icons/ic_24_plus.svg",
                                  width: 24,
                                  height: 24),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuTileBtn(
                      icon: "preview",
                      label: "미리보기",
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) => MenuDetailViewModel(menu!.id),
                              child: MenuDetailView(menuId: menu!.id),
                            ),
                          ),
                        );
                        viewModel!.init();
                      },
                      enable: menu!.status != MenuStatus.hidden),
                  MenuTileBtn(
                      icon: "edit",
                      label: "수정하기",
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) =>
                                  MenuUpdateViewModel(menuId: menu!.id),
                              child: const MenuUpdateView(),
                            ),
                          ),
                        );
                        viewModel!.init();
                      },
                      enable: true),
                  MenuTileBtn(
                      icon: "delete",
                      label: "삭제하기",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            title: "메뉴를 삭제하시겠어요?",
                            content: "선택한 메뉴가 삭제됩니다.",
                            onCanceled: () {
                              Navigator.of(context).pop();
                            },
                            onConfirmed: () async {
                              await viewModel!.deleteMenu(menu!.id);
                              viewModel!.init();
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        );
                      },
                      enable: true),
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
