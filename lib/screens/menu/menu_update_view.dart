import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_origin_textfields.dart';
import 'package:kwangsaeng_seller/screens/menu/widgets/menu_price_textfields.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/date_validator.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/img_upload_card.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';
import 'package:provider/provider.dart';

class MenuUpdateView extends StatelessWidget {
  const MenuUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuUpdateViewModel>(context);
    return Stack(
      children: [
        KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Form(
              key: viewModel.formKey,
              child: Scaffold(
                backgroundColor: KwangColor.grey100,
                appBar: AppBar(
                  title: Text("메뉴 ${viewModel.viewMode.str}하기",
                      style: KwangStyle.header2),
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
                              GestureDetector(
                                  onTap: () async {
                                    await viewModel.uploadImg();
                                  },
                                  child: ImgUploadCard(
                                      imgUrl: viewModel.imgUrl,
                                      imgType: viewModel.imgType)),
                              if (viewModel.imgUrl != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.updateImgUrl(null);
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: KwangColor.grey100,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: KwangColor.grey500),
                                      ),
                                      child: SvgPicture.asset(
                                          "assets/icons/ic_16_close.svg"),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        const TextFieldTitle(title: "메뉴명"),
                        CustomTextField(
                          controller: viewModel.nameController,
                          hintText: "메뉴명을 입력해주세요",
                          validator: (input) {
                            if (input.isEmpty) {
                              return "메뉴명을 입력해주세요";
                            }
                            return null;
                          },
                          maxLength: 20,
                          isVisibleMaxLength: true,
                        ),
                        const SizedBox(height: 20),
                        const TextFieldTitle(title: "소비기한"),
                        CustomTextField(
                          controller: viewModel.expireController,
                          hintText: "YYYYMMDD",
                          validator: (input) {
                            if (input.isEmpty) {
                              return "날짜를 입력해주세요";
                            } else {
                              final date = dateValidator(input);
                              if (date == null) {
                                return "올바른 날짜를 입력해주세요";
                              } else if (DateTime.now()
                                  .add(const Duration(days: -1))
                                  .isAfter(date)) {
                                return "소비기한이 남아있는 메뉴를 등록해주세요";
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          prompt: "*가장 임박한 날짜로 기입해주세요.",
                          maxLength: 8,
                        ),
                        const SizedBox(height: 20),
                        MenuPriceTextFields(viewModel: viewModel),
                        const SizedBox(height: 20),
                        const TextFieldTitle(title: "메뉴 소개"),
                        CustomTextField(
                          controller: viewModel.descriptionController,
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
                        MenuOriginTextFields(viewModel: viewModel),
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
                    txt: "${viewModel.viewMode.str}하기",
                    txtColor: KwangColor.grey100,
                    bgColor: KwangColor.secondary400,
                    onTap: () async {
                      viewModel.validateAll();
                      if (viewModel.checkAreAllValid()) {
                        if (viewModel.viewMode == MenuUpdateViewType.register) {
                          await viewModel.register().then((value) {
                            if (value) Navigator.pop(context);
                          });
                        } else {
                          await viewModel.modify().then((result) {
                            if (result) Navigator.pop(context);
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
        if (viewModel.isLoading) const LoadingPage()
      ],
    );
  }
}
