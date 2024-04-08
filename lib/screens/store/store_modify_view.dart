import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/widgets/register_bottom_sheet.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/time_formatter.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/img_upload_card.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/phone_field.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';
import 'package:provider/provider.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class StoreModifyView extends StatelessWidget {
  const StoreModifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return viewModel.isLoading
        ? const LoadingPage(
            color: KwangColor.secondary400,
            backgroundColor: KwangColor.grey100,
          )
        : Stack(
            children: [
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return Form(
                    key: viewModel.formKey,
                    child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      appBar: AppBar(
                        toolbarHeight: 52,
                        centerTitle: false,
                        title: Text("가게 정보 수정", style: KwangStyle.header2),
                        titleSpacing: 0,
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            behavior: HitTestBehavior.translucent,
                            child: SvgPicture.asset(
                              "assets/icons/ic_36_back.svg",
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ),
                        leadingWidth: 52,
                        backgroundColor: Colors.white,
                        elevation: 0,
                      ),
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20,
                              MediaQuery.of(context).size.height - 260),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 12),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          await viewModel.uploadImg();
                                        },
                                        child: ImgUploadCard(
                                            imgUrl: viewModel.storeImg,
                                            imgType: viewModel.imgType)),
                                    if (viewModel.imgType != ImgType.empty)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            viewModel.updateImgUrl(
                                                null, ImgType.empty);
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
                              const TextFieldTitle(title: "업체명"),
                              CustomTextField(
                                controller: viewModel.storeNameController,
                                hintText: "업체명을 입력해주세요",
                                validator: (input) {
                                  if (viewModel
                                      .storeNameController.text.isEmpty) {
                                    return "업체명을 입력해주세요";
                                  }
                                  return null;
                                },
                                maxLength: 20,
                                isVisibleMaxLength: true,
                              ),
                              const TextFieldTitle(title: "업체 카테고리"),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: viewModel,
                                      child: const RegisterBottomSheet(
                                        type: RegisterBottomSheetType.category,
                                      ),
                                    ),
                                  );
                                  viewModel.checkValidCategory();
                                },
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: viewModel.categoryController,
                                    hintText: "카테고리 선택",
                                    validator: (input) {
                                      if (viewModel
                                          .categoryController.text.isEmpty) {
                                        return "카테고리를 선택해주세요";
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    icon: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 1, 16, 1),
                                      child: SvgPicture.asset(
                                        "assets/icons/ic_16_dropdown.svg",
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                            KwangColor.grey700,
                                            BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "업체 소개"),
                              CustomTextField(
                                controller: viewModel.descriptionController,
                                hintText:
                                    "매장을 소개하는 문구를 작성해주세요 (선택)\n예) 간단하지만 맛있는 일본식 가정식 도시락 전문점",
                                validator: (input) {
                                  return null;
                                },
                                maxLines: 5,
                                maxLength: 50,
                                isVisibleMaxLength: true,
                              ),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "평균 조리시간"),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: viewModel,
                                      child: const RegisterBottomSheet(
                                        type:
                                            RegisterBottomSheetType.cookingTime,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: KwangColor.grey400,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${viewModel.cookingTime == 0 ? "00" : viewModel.cookingTime}분",
                                    style: KwangStyle.body1.copyWith(
                                        color: viewModel.cookingTime == 0
                                            ? KwangColor.grey600
                                            : KwangColor.grey900),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "가게 정보에 표시되는 평균 조리시간입니다",
                                style: KwangStyle.body2
                                    .copyWith(color: KwangColor.grey700),
                              ),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "영업시간"),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: viewModel,
                                      child: const RegisterBottomSheet(
                                        type: RegisterBottomSheetType
                                            .opearatingTime,
                                      ),
                                    ),
                                  );
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: !viewModel
                                                  .isOperationTimeValidated ||
                                              viewModel.isValidOperationTime ==
                                                  true
                                          ? KwangColor.grey400
                                          : KwangColor.red,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        timeFormatter(viewModel.openTime,
                                            TimeFormat.timeToKorStr),
                                        style: KwangStyle.body1.copyWith(
                                            color:
                                                viewModel.isValidOperationTime
                                                    ? KwangColor.grey900
                                                    : KwangColor.grey600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          "~",
                                          style: KwangStyle.body1.copyWith(
                                              color:
                                                  viewModel.isValidOperationTime
                                                      ? KwangColor.grey900
                                                      : KwangColor.grey600),
                                        ),
                                      ),
                                      Text(
                                        timeFormatter(viewModel.closeTime,
                                            TimeFormat.timeToKorStr),
                                        style: KwangStyle.body1.copyWith(
                                            color:
                                                viewModel.isValidOperationTime
                                                    ? KwangColor.grey900
                                                    : KwangColor.grey600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              !viewModel.isOperationTimeValidated ||
                                      viewModel.isValidOperationTime
                                  ? Text(
                                      "지도에 표시 여부 등의 서비스 자동화에 이용됩니다",
                                      style: KwangStyle.body2
                                          .copyWith(color: KwangColor.grey700),
                                    )
                                  : Text(
                                      "영업 시간을 입력해주세요",
                                      style: KwangStyle.body2
                                          .copyWith(color: KwangColor.red),
                                    ),
                              const SizedBox(height: 8),
                              const SizedBox(height: 20),
                              PhoneField(viewModel: viewModel),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "가게 주소"),
                              GestureDetector(
                                onTap: () async {
                                  KopoModel? model = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RemediKopo(),
                                    ),
                                  );
                                  if (model != null) {
                                    viewModel.updateAddress(
                                        model.roadAddress.toString());
                                  }
                                  viewModel.checkValidAddress();
                                },
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: viewModel.addressController,
                                    hintText: "동/리/도로명으로 검색해주세요",
                                    validator: (input) {
                                      if (viewModel
                                          .addressController.text.isEmpty) {
                                        return "가게 주소를 입력해주세요";
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SvgPicture.asset(
                                        "assets/icons/ic_18_arrow_right.svg",
                                        width: 18,
                                        height: 18,
                                        colorFilter: const ColorFilter.mode(
                                            KwangColor.grey600,
                                            BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              CustomTextField(
                                controller: viewModel.detailAddressController,
                                hintText: "건물 층, 호수 등 상세정보를 입력해주세요",
                                validator: (input) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
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
                                : 16 +
                                    MediaQuery.of(context).viewPadding.bottom),
                        decoration: const BoxDecoration(
                          color: KwangColor.grey100,
                        ),
                        child: CustomBtn(
                          txt: "저장하기",
                          txtColor: viewModel.areValidModify
                              ? KwangColor.grey100
                              : KwangColor.grey600,
                          bgColor: viewModel.areValidModify
                              ? KwangColor.secondary400
                              : KwangColor.grey300,
                          onTap: () async {
                            viewModel.formKey.currentState!.validate();
                            viewModel.validateAll();
                            viewModel.checkAreValidModify();
                            if (viewModel.areValidModify) {
                              viewModel.changeIsRegistering(true);
                              if (await viewModel.modify()) {
                                showToast("가게 정보가 수정되었습니다");
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } else {
                                showToast("가게 수정에 실패했습니다. 다시 시도해주세요");
                              }
                              viewModel.changeIsRegistering(false);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (viewModel.isRegistering) const LoadingPage()
            ],
          );
  }
}
