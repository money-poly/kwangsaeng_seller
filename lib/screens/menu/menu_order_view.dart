import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_order_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_tile.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:provider/provider.dart';

class MenuOrderView extends StatelessWidget {
  const MenuOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuOrderViewModel>(context);
    return Scaffold(
      backgroundColor: KwangColor.grey200,
      appBar: AppBar(
        title: Text("순서 편집", style: KwangStyle.header2),
        toolbarHeight: 64,
        titleSpacing: 8,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/icons/ic_36_back.svg",
              width: 36,
              height: 36,
            ),
          ),
        ),
        leadingWidth: 44,
        backgroundColor: KwangColor.grey200,
        elevation: 0,
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 124),
        children: [
          for (int idx = 0; idx < viewModel.modifiedMenus!.length; idx++)
            MenuTile(
              key: Key("$idx"),
              type: MenuTileType.changeOrder,
              menu: viewModel.modifiedMenus![idx],
            )
        ],
        onReorder: (oldIdx, newIdx) {
          viewModel.changeOrder(oldIdx, newIdx);
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            20, 16, 20, 16 + MediaQuery.of(context).viewPadding.bottom),
        decoration: const BoxDecoration(
          color: KwangColor.grey200,
        ),
        child: GestureDetector(
          onTap: () {
            if (viewModel.isChangedOrder) {}
          },
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: viewModel.isChangedOrder
                  ? KwangColor.secondary400
                  : KwangColor.grey400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("확인",
                style: KwangStyle.btn2B.copyWith(
                    color: viewModel.isChangedOrder
                        ? KwangColor.grey100
                        : KwangColor.grey600)),
          ),
        ),
      ),
    );
  }
}
