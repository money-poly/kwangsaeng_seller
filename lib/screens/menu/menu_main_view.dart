import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_main_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_order_view.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_order_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_register_view.dart';
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
      return Scaffold(
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (_) => MenuOrderViewModel(),
                          child: const MenuOrderView()),
                    ),
                  );
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Text(
                      "순서 편집",
                      style:
                          KwangStyle.btn2SB.copyWith(color: KwangColor.grey700),
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
          toolbarHeight: 48,
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
                      10,
                      (index) => Column(
                        children: [
                          const MenuTile(
                            type: MenuTileType.main,
                            menu: null,
                          ),
                          if (index != 9)
                            const SizedBox(
                              height: 20,
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );
    }
  }
}
