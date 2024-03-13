import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/screens/store/store_modify_view.dart';
import 'package:kwangsaeng_seller/screens/store/store_preview_view_model.dart';
import 'package:kwangsaeng_seller/screens/store/widgets/store_info_row.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/origin_formatter.dart';
import 'package:kwangsaeng_seller/widgets/bullet_string.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class StorePreviewView extends StatelessWidget {
  const StorePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StorePreviewViewModel>(context);
    return viewModel.isLoading
        ? const LoadingPage(
            color: KwangColor.secondary400,
            backgroundColor: KwangColor.grey100,
          )
        : Scaffold(
            backgroundColor: KwangColor.grey100,
            appBar: AppBar(
              title: Text("매장 상세", style: KwangStyle.header2),
              toolbarHeight: 44,
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
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StoreModifyView(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "정보 수정",
                          style: KwangStyle.btn2SB
                              .copyWith(color: KwangColor.grey700),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              leadingWidth: 44,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                if (viewModel.store!.imgUrl != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 244,
                    child: ExtendedImage.network(viewModel.store!.imgUrl!,
                        fit: BoxFit.cover),
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
                          Text(
                            viewModel.store!.categories.join(", "),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: KwangColor.grey600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            viewModel.store!.name,
                            style: KwangStyle.header1,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                              title: "매장주소",
                              content: viewModel.store!.address,
                              hasPaddingBottom: true),
                          StoreInfoRow(
                              title: "영업시간",
                              content:
                                  "${viewModel.store!.openTime} ~ ${viewModel.store!.closeTime}",
                              hasPaddingBottom: true),
                          const StoreInfoRow(
                              title: "픽업시간",
                              content: "사용자의 위치와 조리시간을 고려해 산출됩니다.",
                              hasPaddingBottom: true),
                          StoreInfoRow(
                              title: "전화번호",
                              content: viewModel.store!.phone,
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
                            target: LatLng(viewModel.store!.latLng.latitude,
                                viewModel.store!.latLng.longitude),
                            zoom: 16,
                          ),
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          markers: {
                            Marker(
                                markerId: const MarkerId("store"),
                                position: viewModel.store!.latLng,
                                icon: viewModel.markerIcon!)
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 8),
                      height: 4,
                      color: KwangColor.grey200,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        child: Text("메뉴", style: KwangStyle.header2)),
                    if (viewModel.store!.menu.isEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Text("아직 등록된 메뉴가 없어요!",
                            style: KwangStyle.body1M
                                .copyWith(color: KwangColor.grey700)),
                      ),
                    if (viewModel.store!.menu.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children: viewModel.store!.menu
                              .map(
                                (e) => MenuCard(
                                  menu: e,
                                  type: MenuCardType.horizontal,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (viewModel.store!.origins.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
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
                                originFormatter(viewModel.store!.origins),
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
                      margin: const EdgeInsets.only(bottom: 4),
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
                              MediaQuery.of(context).viewPadding.bottom + 52),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: viewModel.store!.notes
                            .map((e) => BulletString(
                                  txt: e,
                                  style: KwangStyle.body2,
                                  hasBottomPadding:
                                      e != viewModel.store!.notes.last,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
  }
}
