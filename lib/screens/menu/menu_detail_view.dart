import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_detail_view_model.dart';
import 'package:kwangsaeng_seller/screens/store/widgets/store_info_row.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/datetime_formatter.dart';
import 'package:kwangsaeng_seller/utils.dart/origin_formatter.dart';
import 'package:kwangsaeng_seller/widgets/bullet_string.dart';
import 'package:kwangsaeng_seller/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class MenuDetailView extends StatelessWidget {
  const MenuDetailView({super.key, required this.menuId});

  final int menuId;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuDetailViewModel>(context);
    return viewModel.menu == null
        ? const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: KwangColor.secondary400,
            )),
          )
        : Scaffold(
            backgroundColor: KwangColor.grey100,
            appBar: AppBar(
              title: Text("메뉴상세 미리보기", style: KwangStyle.header2),
              toolbarHeight: 52,
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
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await viewModel.getDetailMenu(menuId);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (viewModel.menu!.menuPictureUrl != null)
                      Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 244,
                            child: ExtendedImage.network(
                                viewModel.menu!.menuPictureUrl!,
                                fit: BoxFit.cover),
                          ),
                          if (viewModel.menu!.count == 0)
                            Container(
                              height: 244,
                              alignment: Alignment.center,
                              color: KwangColor.black.withOpacity(0.4),
                              child: Text(
                                "품절",
                                style: KwangStyle.header3.copyWith(
                                  color: KwangColor.grey100,
                                ),
                              ),
                            )
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (viewModel.menu!.description != null)
                                Text(
                                  viewModel.menu!.description!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: KwangColor.grey600),
                                ),
                              if (viewModel.menu!.description != null)
                                const SizedBox(
                                  height: 4,
                                ),
                              Text(
                                viewModel.menu!.name,
                                style: KwangStyle.header1,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    NumberFormat('###,###,###,###')
                                        .format(viewModel.menu!.regularPrice)
                                        .replaceAll(' ', ','),
                                    style: KwangStyle.header1.copyWith(
                                        color: KwangColor.grey600,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${viewModel.menu!.discountRate}%",
                                        style: KwangStyle.header0
                                            .copyWith(color: KwangColor.red),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          "${NumberFormat('###,###,###,###').format(viewModel.menu!.discountPrice).replaceAll(' ', ',')}원",
                                          style: KwangStyle.header0),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: KwangColor.grey300, width: 1),
                            ),
                          ),
                          child: StoreInfoRow(
                            title: "소비기한",
                            content: dateToStr(DateTimStrType.korean,
                                viewModel.menu!.expiredDate),
                            hasPaddingBottom: false,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: KwangColor.grey300,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Column(
                            children: [
                              StoreInfoRow(
                                  title: "매장이름",
                                  content: viewModel.menu!.store.name,
                                  hasPaddingBottom: true),
                              StoreInfoRow(
                                  title: "매장주소",
                                  content: viewModel.menu!.store.address,
                                  hasPaddingBottom: true,
                                  selectable: true),
                              StoreInfoRow(
                                  title: "픽업시간",
                                  content:
                                      "${viewModel.menu!.store.pickUpTime}분",
                                  hasPaddingBottom: true),
                              StoreInfoRow(
                                  title: "전화번호",
                                  content: viewModel.menu!.store.phone,
                                  hasPaddingBottom: false),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: KwangColor.grey300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 100,
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: viewModel.menu!.store.latLng,
                                zoom: 16,
                              ),
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                              markers: {
                                Marker(
                                  markerId: const MarkerId("store"),
                                  position: viewModel.menu!.store.latLng,
                                  icon: viewModel.markerOffIcon!,
                                )
                              }),
                        ),
                        if (viewModel.menu!.anotherMenus.isNotEmpty ||
                            viewModel.menu!.origins.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 8),
                            height: 4,
                            color: KwangColor.grey200,
                          ),
                        if (viewModel.menu!.anotherMenus.isNotEmpty)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              child: Text("이 매장 또 다른 메뉴",
                                  style: KwangStyle.header2)),
                        if (viewModel.menu!.anotherMenus.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Wrap(
                              direction: Axis.vertical,
                              spacing: 20,
                              children: viewModel.menu!.anotherMenus
                                  .map(
                                    (e) => MenuCard(
                                        menu: e, type: MenuCardType.horizontal),
                                  )
                                  .toList(),
                            ),
                          ),
                        if (viewModel.menu!.origins.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: KwangColor.grey300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "원산지 표기",
                                  style: KwangStyle.body2M
                                      .copyWith(color: KwangColor.grey600),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    originFormatter(viewModel.menu!.origins),
                                    style: KwangStyle.body2M.copyWith(
                                        color: KwangColor.grey800,
                                        overflow: TextOverflow.visible),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 4, top: 20),
                          height: 4,
                          color: KwangColor.grey200,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: Text("유의사항", style: KwangStyle.header2)),
                        Container(
                          margin: EdgeInsets.only(
                              top: 8,
                              bottom:
                                  MediaQuery.of(context).viewPadding.bottom +
                                      102),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: viewModel.menu!.cautions
                                .map((e) => BulletString(
                                      txt: e,
                                      style: KwangStyle.body2,
                                      hasBottomPadding: viewModel.menu!.cautions
                                              .indexOf(e) !=
                                          viewModel.menu!.cautions.length - 1,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              height: 70 + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                border: const Border(
                    top: BorderSide(color: KwangColor.grey300, width: 1)),
                color: viewModel.menu!.count == 0
                    ? KwangColor.grey300
                    : KwangColor.grey100,
              ),
              alignment: Alignment.center,
              child: viewModel.menu!.count == 0
                  ? Text("품절",
                      style: KwangStyle.header3
                          .copyWith(color: KwangColor.grey600))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_20_alarm.svg",
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                              KwangColor.red, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${viewModel.menu!.count}개 ",
                          style: KwangStyle.header3
                              .copyWith(color: KwangColor.red),
                        ),
                        Text("밖에 안남았어요.", style: KwangStyle.header3),
                      ],
                    ),
            ),
          );
  }
}
