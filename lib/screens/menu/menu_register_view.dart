import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/img_upload_card.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';

class MenuRegisterView extends StatelessWidget {
  const MenuRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Scaffold(
              backgroundColor: KwangColor.grey100,
              appBar: AppBar(
                title: Text("메뉴 등록하기", style: KwangStyle.header2),
                leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset("assets/icons/ic_36_back.svg",
                        width: 36, height: 36),
                  ),
                ),
                leadingWidth: 52,
                titleSpacing: 0,
                toolbarHeight: 52,
                centerTitle: false,
                backgroundColor: KwangColor.grey100,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20,
                      144 + MediaQuery.of(context).viewPadding.bottom),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 12),
                        child: Stack(
                          children: [
                            const ImgUploadCard(imgUrl: null),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: KwangColor.grey100,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: KwangColor.grey500),
                                ),
                                child: SvgPicture.asset(
                                    "assets/icons/ic_16_close.svg"),
                              ),
                            )
                          ],
                        ),
                      ),
                      const TextFieldTitle(title: "메뉴명"),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText: "메뉴명을 입력해주세요",
                        validator: (input) {
                          return null;
                        },
                        maxLength: 20,
                        isVisibleMaxLength: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldTitle(title: "정가"),
                                CustomTextField(
                                  controller: TextEditingController(),
                                  hintText: "0",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (input) {
                                    return null;
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      "원",
                                      style: KwangStyle.body1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldTitle(title: "판매가"),
                                CustomTextField(
                                  controller: TextEditingController(),
                                  hintText: "0",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (input) {
                                    return null;
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      "원",
                                      style: KwangStyle.body1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "현재 ",
                            style: KwangStyle.body2
                                .copyWith(color: KwangColor.grey700),
                          ),
                          Text(
                            "25.4% ",
                            style: KwangStyle.body2M
                                .copyWith(color: KwangColor.red),
                          ),
                          Text(
                            "할인",
                            style: KwangStyle.body2
                                .copyWith(color: KwangColor.grey700),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TextFieldTitle(title: "메뉴 소개"),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText:
                            "메뉴를 소개하는 문구를 작성해주세요 (선택)\n예) 산미 없이 고소하게 즐기는 아메리카노",
                        validator: (input) {
                          return null;
                        },
                        maxLines: 5,
                        maxLength: 100,
                        isVisibleMaxLength: true,
                      ),
                      const SizedBox(height: 20),
                      const TextFieldTitle(title: "원산지 표기"),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: CustomTextField(
                                controller: TextEditingController(),
                                hintText: "재료명",
                                validator: (input) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              flex: 2,
                              child: CustomTextField(
                                controller: TextEditingController(),
                                hintText: "원산지",
                                validator: (input) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {},
                              behavior: HitTestBehavior.translucent,
                              child: SvgPicture.asset(
                                "assets/icons/ic_24_trash.svg",
                                width: 24,
                                height: 24,
                                colorFilter: const ColorFilter.mode(
                                    KwangColor.grey800, BlendMode.srcIn),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
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
                                style: KwangStyle.body1
                                    .copyWith(color: KwangColor.grey600),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                "assets/icons/ic_16_add.svg",
                                width: 16,
                                height: 16,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              bottomSheet: Container(
                padding: EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    isKeyboardVisible
                        ? 16
                        : 16 + MediaQuery.of(context).viewPadding.bottom),
                decoration: const BoxDecoration(
                  color: KwangColor.grey100,
                ),
                child: CustomBtn(
                  txt: "등록하기",
                  txtColor: KwangColor.grey100,
                  bgColor: KwangColor.secondary400,
                  onTap: () {},
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
