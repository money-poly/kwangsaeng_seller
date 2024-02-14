import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/home/home_view_model.dart';
import 'package:kwangsaeng_seller/screens/home/widgets/tag_bottom_sheet.dart';
import 'package:kwangsaeng_seller/screens/store/store_preview_view.dart';
import 'package:kwangsaeng_seller/screens/store/store_preview_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/tag_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    if (viewModel.isLoading) {
      return const LoadingPage(color: KwangColor.secondary400);
    } else {
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
              Text(viewModel.store!.owner, style: KwangStyle.appBar1),
              const SizedBox(width: 4),
              Text(
                "사장님",
                style:
                    KwangStyle.appBar2.copyWith(color: KwangColor.primary400),
              ),
            ],
          ),
          toolbarHeight: 64,
          titleSpacing: 20,
          centerTitle: false,
          backgroundColor: KwangColor.grey200,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                              color: viewModel.status!.isOpen
                                  ? KwangColor.secondary400
                                  : KwangColor.grey600,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("현재 영업 상태",
                                    style: KwangStyle.header3
                                        .copyWith(color: KwangColor.grey100)),
                                Text(
                                  viewModel.status!.name
                                      .toString()
                                      .toUpperCase(),
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
                                    if (viewModel.store!.storePictureUrl !=
                                        null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: ExtendedImage.network(
                                          viewModel.store!.storePictureUrl!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    if (viewModel.store!.storePictureUrl !=
                                        null)
                                      const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(viewModel.store!.category,
                                            style: KwangStyle.body2M.copyWith(
                                                color: KwangColor.grey600)),
                                        const SizedBox(height: 4),
                                        Text(viewModel.store!.name,
                                            style: KwangStyle.btn2SB),
                                        const SizedBox(height: 8),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider(
                                                  create: (_) =>
                                                      StorePreviewViewModel(),
                                                  child:
                                                      const StorePreviewView(),
                                                ),
                                              ),
                                            );
                                          },
                                          behavior: HitTestBehavior.translucent,
                                          child: Row(
                                            children: [
                                              Text(
                                                "매장 상세",
                                                style: KwangStyle.body2M
                                                    .copyWith(
                                                        color: KwangColor
                                                            .secondary400),
                                              ),
                                              const SizedBox(width: 4),
                                              SvgPicture.asset(
                                                "assets/icons/ic_18_arrow_right.svg",
                                                width: 16,
                                                height: 16,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        KwangColor.secondary400,
                                                        BlendMode.srcIn),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 32,
                                  child: CupertinoSwitch(
                                    value: viewModel.status!.isOpen,
                                    onChanged: (value) {
                                      viewModel.switchStoreStatus();
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
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    ChangeNotifierProvider.value(
                                  value: viewModel,
                                  child: const TagBottomSheet(),
                                ),
                              );
                            },
                            child: Container(
                              height: 88,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: KwangColor.grey100,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  viewModel.store!.tag == null
                                      ? Text(
                                          "태그를 선택하세요!",
                                          style: KwangStyle.body2.copyWith(
                                              color: KwangColor.grey600),
                                        )
                                      : TagWidget(
                                          tag: viewModel.store!.tag!,
                                        ),
                                ],
                              ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "할인 메뉴",
                                      style: KwangStyle.btn2SB,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        viewModel.store!.discountMenuCnt
                                            .toString(),
                                        style: KwangStyle.header0),
                                    const SizedBox(width: 4),
                                    Text(
                                        "개 / ${viewModel.store!.totalMenuCnt}개",
                                        style: KwangStyle.body1),
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
            if (viewModel.isChangeLoading)
              const LoadingPage(color: KwangColor.secondary400)
          ],
        ),
      );
    }
  }
}
