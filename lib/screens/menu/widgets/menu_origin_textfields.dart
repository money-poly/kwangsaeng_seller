import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';

class MenuOriginTextFields extends StatelessWidget {
  const MenuOriginTextFields({super.key, required this.viewModel});

  final MenuUpdateViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldTitle(title: "원산지 표기"),
        if (viewModel.origins.isNotEmpty)
          Wrap(
            direction: Axis.vertical,
            spacing: 8,
            children: viewModel.origins
                .map(
                  (e) => Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: CustomTextField(
                                controller: e.item1,
                                hintText: "재료명",
                                validator: (input) {
                                  if (!viewModel.areValidOrigins[
                                      viewModel.origins.indexOf(e)]) {
                                    return "";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: CustomTextField(
                                controller: e.item2,
                                hintText: "원산지",
                                validator: (input) {
                                  if (!viewModel.areValidOrigins[
                                      viewModel.origins.indexOf(e)]) {
                                    return "";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                viewModel
                                    .removeOrigin(viewModel.origins.indexOf(e));
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: SvgPicture.asset(
                                  "assets/icons/ic_24_trash.svg",
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                      KwangColor.grey800, BlendMode.srcIn),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (!viewModel
                          .areValidOrigins[viewModel.origins.indexOf(e)])
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Text("재료명과 원산지를 모두 입력해주세요",
                                style: KwangStyle.body2
                                    .copyWith(color: KwangColor.red)))
                    ],
                  ),
                )
                .toList(),
          ),
        if (viewModel.origins.isNotEmpty) const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            viewModel.addOrigin();
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: KwangColor.grey400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "추가하기",
                  style: KwangStyle.body1.copyWith(color: KwangColor.grey600),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  "assets/icons/ic_16_add.svg",
                  width: 16,
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
