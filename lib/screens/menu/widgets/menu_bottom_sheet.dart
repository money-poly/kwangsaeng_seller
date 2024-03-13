import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_main_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_status_widget.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

enum MenuBottomSheetType { status, more }

enum MenuMoreBtnType {
  edit("수정하기"),
  delete("삭제하기");

  const MenuMoreBtnType(this.str);
  final String str;
}

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({super.key, required this.type, required this.menuIdx});

  final MenuBottomSheetType type;
  final int menuIdx;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuMainViewModel>(context);
    switch (type) {
      case MenuBottomSheetType.status:
        return Container(
          height: 64 * MenuStatus.values.length +
              12 * MenuStatus.values.length -
              1 +
              60,
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 40),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: KwangColor.grey100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: 44,
                height: 6,
                decoration: BoxDecoration(
                  color: KwangColor.grey300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Column(
                children: List.generate(
                  MenuStatus.values.length,
                  (idx) => GestureDetector(
                    onTap: () {
                      viewModel.changeMenuStatus(
                          menuIdx, MenuStatus.values[idx]);
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: idx == MenuStatus.values.length - 1
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(MenuStatus.values[idx].str,
                                        style: KwangStyle.btn1SB),
                                    const SizedBox(width: 8),
                                    MenuStatusWidget(
                                      status: MenuStatus.values[idx],
                                      isSelectable: false,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  MenuStatus.values[idx].description,
                                  style: KwangStyle.body1M
                                      .copyWith(color: KwangColor.grey600),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (viewModel.menus[menuIdx].status ==
                              MenuStatus.values[idx])
                            SvgPicture.asset(
                              "assets/icons/ic_36_check.svg",
                              width: 36,
                              height: 36,
                              colorFilter: const ColorFilter.mode(
                                  KwangColor.secondary400, BlendMode.srcIn),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case MenuBottomSheetType.more:
        return Container(
          height: 52 * MenuMoreBtnType.values.length +
              12 * (MenuMoreBtnType.values.length - 1) +
              80,
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 60),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: KwangColor.grey100,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: 44,
                height: 6,
                decoration: BoxDecoration(
                  color: KwangColor.grey300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Column(
                children: List.generate(
                  MenuMoreBtnType.values.length,
                  (idx) => GestureDetector(
                    onTap: () async {
                      switch (MenuMoreBtnType.values[idx]) {
                        case MenuMoreBtnType.edit:
                          Navigator.of(context).pop();
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) => MenuUpdateViewModel(
                                    menuId: viewModel.menus[menuIdx].id),
                                child: const MenuUpdateView(),
                              ),
                            ),
                          );
                          viewModel.init();
                          break;
                        case MenuMoreBtnType.delete:
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              title: "메뉴를 삭제하시겠어요?",
                              content: "선택한 메뉴가 삭제됩니다.",
                              onCanceled: () {
                                Navigator.of(context).pop();
                              },
                              onConfirmed: () async {
                                await viewModel
                                    .deleteMenu(viewModel.menus[menuIdx].id);
                                viewModel.init();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          );
                          break;
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 52,
                      margin: idx == MenuMoreBtnType.values.length - 1
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(bottom: 12),
                      child: Text(
                        MenuMoreBtnType.values[idx].str,
                        style: KwangStyle.btn1SB,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
