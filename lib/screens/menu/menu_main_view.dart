import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_main_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_order_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_order_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_register_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_register_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_tile.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/empty_card.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class MenuMainView extends StatelessWidget {
  const MenuMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuMainViewModel>(context);
    if (viewModel.isLoading) {
      return const LoadingPage(
        color: KwangColor.secondary400,
      );
    } else {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: KwangColor.grey200,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("메뉴 관리", style: KwangStyle.header1),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: Text(
                      "미리보기",
                      style: KwangStyle.btn2SB
                          .copyWith(color: KwangColor.secondary400),
                    ),
                  )
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (_) =>
                                  MenuOrderViewModel(viewModel.menus),
                              child: const MenuOrderView()),
                        ),
                      );
                      viewModel.init();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Text(
                          "순서 편집",
                          style: KwangStyle.btn2SB
                              .copyWith(color: KwangColor.grey700),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          "assets/icons/ic_20_transfer.svg",
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                              KwangColor.grey700, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              titleSpacing: 20,
              toolbarHeight: 62,
              centerTitle: false,
              backgroundColor: KwangColor.grey200,
              elevation: 0,
            ),
            body: viewModel.menus.isEmpty
                ? const EmptyCard(emptyType: EmptyCardType.menu)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 64),
                      child: Column(
                        children: List.generate(
                          viewModel.menus.length,
                          (index) => Column(
                            children: [
                              MenuTile(
                                type: MenuTileType.main,
                                menu: viewModel.menus[index],
                                idx: index,
                                viewModel: viewModel,
                              ),
                              if (index != viewModel.menus.length - 1)
                                const SizedBox(
                                  height: 20,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                        create: (_) => MenuRegisterViewModel(),
                        child: const MenuRegisterView()),
                  ),
                );
                viewModel.init();
              },
              child: Container(
                width: 143,
                decoration: BoxDecoration(
                  color: KwangColor.secondary400,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "메뉴 추가하기",
                        style: KwangStyle.btn1SB
                            .copyWith(color: KwangColor.grey100),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        "assets/icons/ic_24_add.svg",
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            KwangColor.grey100, BlendMode.srcIn),
                      )
                    ]),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
          if (viewModel.isWorking) const LoadingPage(),
        ],
      );
    }
  }
}
