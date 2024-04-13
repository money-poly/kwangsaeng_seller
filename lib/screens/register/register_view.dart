import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/widgets/register_bottom_sheet.dart';
import 'package:kwangsaeng_seller/screens/start/waiting_view.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/date_validator.dart';
import 'package:kwangsaeng_seller/utils.dart/time_formatter.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/phone_field.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';
import 'package:provider/provider.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return viewModel.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: KwangColor.secondary400,
            ),
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
                              const SizedBox(height: 8),
                              Text(
                                "광생 사장님 등록을 위해\n가게정보를 입력해주세요.",
                                style: KwangStyle.header1,
                              ),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "대표자명"),
                              CustomTextField(
                                controller: viewModel.nameController,
                                hintText: "대표자명을 입력해주세요",
                                validator: (input) {
                                  if (viewModel.nameController.text.isEmpty) {
                                    return "대표자명을 입력해주세요";
                                  }
                                  return null;
                                },
                                maxLength: 5,
                                isVisibleMaxLength: true,
                              ),
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 20),
                              PhoneField(viewModel: viewModel),
                              const SizedBox(height: 20),
                              const TextFieldTitle(title: "사업자 등록번호"),
                              CustomTextField(
                                controller: viewModel.businessNumberController,
                                hintText: "번호를 입력해주세요",
                                validator: (input) {
                                  if (viewModel
                                      .businessNumberController.text.isEmpty) {
                                    return "사업자 등록번호를 입력해주세요";
                                  } else if (viewModel.businessNumberController
                                          .text.length !=
                                      10) {
                                    return "사업자 번호는 10자리입니다";
                                  }
                                  return null;
                                },
                                maxLength: 10,
                              ),
                              const SizedBox(height: 20),
                              if (viewModel.viewMode ==
                                  StoreUpdateViewType.register)
                                const TextFieldTitle(title: "개업일자"),
                              if (viewModel.viewMode ==
                                  StoreUpdateViewType.register)
                                CustomTextField(
                                  controller: viewModel.startDateController,
                                  hintText: "YYYYMMDD",
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "날짜를 입력해주세요";
                                    } else {
                                      final date = dateValidator(input);
                                      if (date == null) {
                                        return "올바른 날짜를 입력해주세요";
                                      }
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 8,
                                ),
                              const SizedBox(height: 20),
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
                          txt: "다음",
                          txtColor: viewModel.areValidRegister
                              ? KwangColor.grey100
                              : KwangColor.grey600,
                          bgColor: viewModel.areValidRegister
                              ? KwangColor.secondary400
                              : KwangColor.grey300,
                          onTap: () async {
                            viewModel.formKey.currentState!.validate();
                            viewModel.validateAll();
                            viewModel.checkAreValidRegister();
                            if (viewModel.areValidRegister) {
                              viewModel.changeIsRegistering(true);
                              if (await viewModel.register()) {
                                if (context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WaitingView()),
                                  );
                                }
                              } else {
                                showToast("가게 등록에 실패했습니다. 다시 시도해주세요");
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
