import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/join/join_view_model.dart';
import 'package:kwangsaeng_seller/screens/join/widgets/auth_number_btn.dart';
import 'package:kwangsaeng_seller/screens/join/widgets/email_bottom_sheet.dart';
import 'package:kwangsaeng_seller/screens/register/register_view.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/phone_number_formatter.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class JoinView extends StatelessWidget {
  const JoinView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Form(
          key: viewModel.formKey,
          child: Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  toolbarHeight: 52,
                  centerTitle: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, 0, 20, MediaQuery.of(context).size.height - 290),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "안녕하세요!\n가입을 진행해주세요.",
                          style: KwangStyle.header1,
                        ),
                        const SizedBox(height: 20),
                        const TextFieldTitle(title: "휴대폰 번호"),
                        Stack(
                          children: [
                            CustomTextField(
                              controller: viewModel.phoneController,
                              hintText: "휴대폰 번호를 입력해주세요",
                              validator: (input) {
                                if (input.length >= 10 &&
                                    input.contains(RegExp(r'^[0-9]*$'))) {
                                  return null;
                                } else {
                                  return "휴대폰 번호를 바르게 입력해주세요";
                                }
                              },
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                PhoneNumberFormatter(),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              readOnly: viewModel.authStatus !=
                                  AuthNumberBtnType.before,
                            ),
                            if (viewModel.authStatus == AuthNumberBtnType.wait)
                              Positioned(
                                top: 8,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () {},
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: KwangColor.grey300),
                                    child: Text(
                                      "재전송",
                                      style: KwangStyle.body2M.copyWith(
                                          color: KwangColor.secondary400),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 12),
                        AuthNumberBtn(
                            status: viewModel.authStatus,
                            enable:
                                viewModel.phoneController.text.length == 11),
                        const SizedBox(height: 20),
                        const TextFieldTitle(title: "이메일"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: CustomTextField(
                                controller: viewModel.idController,
                                hintText: "이메일 앞자리",
                                validator: (input) {
                                  if (viewModel.idController.text.isEmpty ||
                                      viewModel.domainController.text.isEmpty) {
                                    return "이메일을 입력해주세요";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: Text("@", style: KwangStyle.body1),
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: viewModel.domainController,
                                hintText: "이메일 뒷자리",
                                validator: (input) {
                                  if (viewModel.idController.text.isEmpty ||
                                      viewModel.domainController.text.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  ChangeNotifierProvider.value(
                                value: viewModel,
                                child: const EmailBottomSheet(),
                              ),
                            );
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: KwangColor.grey400,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(viewModel.selDomain ?? "직접 입력",
                                    style: KwangStyle.body1),
                                SvgPicture.asset(
                                  "assets/icons/ic_16_dropdown.svg",
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                      KwangColor.grey700, BlendMode.srcIn),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const TextFieldTitle(title: "비밀번호"),
                        CustomTextField(
                          controller: viewModel.passwordController,
                          hintText: "비밀번호 입력",
                          validator: (input) {
                            if (input.length < 8 ||
                                !RegExp(r'[!@#%^&*(),.?":{}|<>]')
                                    .hasMatch(input)) {
                              return "특수문자 포함 8글자 이상으로 입력해주세요";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          isObsecure: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: viewModel.rePasswordController,
                          hintText: "비밀번호 재입력",
                          validator: (input) {
                            if (viewModel.rePasswordController.text.isEmpty) {
                              return "비밀번호를 재입력해주세요.";
                            } else if (viewModel.passwordController.text !=
                                input) {
                              return "비밀번호가 일치하지 않습니다";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          isObsecure: true,
                          prompt: "영문+숫자+특수기호 8자 이상으로 입력해주세요",
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
                            : 16 + MediaQuery.of(context).viewPadding.bottom),
                    decoration: const BoxDecoration(
                      color: KwangColor.grey100,
                    ),
                    child: viewModel.areValidJoin
                        ? CustomBtn(
                            txt: "확인",
                            txtColor: KwangColor.grey100,
                            bgColor: KwangColor.secondary400,
                            onTap: () async {
                              viewModel.formKey.currentState!.validate();
                              if (await viewModel.join()) {
                                if (context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (_) =>
                                                  RegisterViewModel(),
                                              child: const RegisterView()),
                                    ),
                                  );
                                }
                              }
                            })
                        : CustomBtn(
                            txt: "확인",
                            txtColor: KwangColor.grey600,
                            bgColor: KwangColor.grey300,
                            onTap: () {
                              viewModel.formKey.currentState!.validate();
                              // viewModel.switchIsSubmitted();
                            })),
              ),
              if (viewModel.isLoading) const LoadingPage()
            ],
          ),
        );
      },
    );
  }
}
