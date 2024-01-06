import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 40),
                child: Image.asset(
                  "assets/imgs/img_104_logo_hor.png",
                  width: 104,
                  height: 46,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "남은 음식.\n버리지 말고 광생하세요!",
                    style: KwangStyle.header0,
                  )
                ],
              ),
              const SizedBox(height: 36),
              CustomTextField(
                  controller: TextEditingController(),
                  hintText: "이메일을 입력해주세요",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "이메일을 입력해주세요";
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return "이메일 형식이 올바르지 않습니다";
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              CustomTextField(
                  isObsecure: true,
                  controller: TextEditingController(),
                  hintText: "비밀번호를 입력해주세요",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "비밀번호를 입력해주세요";
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              CustomBtn(
                txt: "로그인",
                txtColor: KwangColor.grey100,
                bgColor: KwangColor.secondary400,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "회원가입",
                      style:
                          KwangStyle.body1.copyWith(color: KwangColor.grey700),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 14,
                    color: KwangColor.grey400,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "문의하기",
                      style:
                          KwangStyle.body1.copyWith(color: KwangColor.grey700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
