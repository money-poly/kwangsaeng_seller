import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwangsaeng_seller/screens/join/join_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

enum AuthNumberBtnType {
  before,
  wait,
  after,
}

class AuthNumberBtn extends StatelessWidget {
  const AuthNumberBtn({super.key, required this.status, required this.enable});

  final AuthNumberBtnType status;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    switch (status) {
      case AuthNumberBtnType.before:
        return GestureDetector(
          onTap: () {
            viewModel.changeAuthStatus(AuthNumberBtnType.wait);
          },
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: enable ? KwangColor.secondary400 : KwangColor.grey300,
            ),
            child: Text(
              "인증문자 받기",
              style: KwangStyle.btn2B.copyWith(
                color: enable ? KwangColor.grey100 : KwangColor.grey600,
              ),
            ),
          ),
        );
      case AuthNumberBtnType.wait:
        return Column(
          children: [
            Stack(
              children: [
                CustomTextField(
                  controller: viewModel.codeController,
                  hintText: "인증번호 입력",
                  validator: (input) {
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.requestAuthCode();
                    },
                    child: Text(
                        "${viewModel.authTime ~/ 60}:${(viewModel.authTime % 60).toString().padLeft(2, "0")}",
                        style: KwangStyle.body1
                            .copyWith(color: KwangColor.grey700)),
                  ),
                ),
              ],
            ),
            if (viewModel.authSuccess != true)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: viewModel.authSuccess == null
                        ? Text(
                            "인증 번호가 발송되었습니다.",
                            style: KwangStyle.body2
                                .copyWith(color: KwangColor.grey700),
                          )
                        : Text(
                            "인증 번호가 잘못되었습니다.",
                            style: KwangStyle.body2
                                .copyWith(color: KwangColor.red),
                          ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            CustomBtn(
              txt: "인증하기",
              txtColor: viewModel.codeController.text.length == 6
                  ? KwangColor.grey100
                  : KwangColor.grey600,
              bgColor: viewModel.codeController.text.length == 6
                  ? KwangColor.secondary400
                  : KwangColor.grey300,
              onTap: viewModel.codeController.text.length == 6
                  ? () async {
                      if (await viewModel.verifyAuthCode()) {
                        viewModel.changeAuthStatus(AuthNumberBtnType.after);
                      }
                    }
                  : () {},
              height: 44,
            ),
          ],
        );
      case AuthNumberBtnType.after:
        return CustomBtn(
          txt: "인증 완료",
          txtColor: KwangColor.secondary400,
          bgColor: KwangColor.secondary100,
          onTap: () {},
        );
    }
  }
}
