import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kwangsaeng_seller/main.dart';
import 'package:kwangsaeng_seller/screens/join/join_view.dart';
import 'package:kwangsaeng_seller/screens/join/join_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/register_view.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/screens/start/start_view_model.dart';
import 'package:kwangsaeng_seller/screens/start/waiting_view.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/loading_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StartViewModel>(context);
    return Form(
      key: viewModel.formKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
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
                        controller: viewModel.emailController,
                        hintText: "이메일을 입력해주세요",
                        validator: (input) {
                          if (input.isEmpty) {
                            return "이메일을 입력해주세요";
                          } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                              .hasMatch(input)) {
                            return "이메일 형식이 올바르지 않습니다";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        isObsecure: true,
                        controller: viewModel.passwordController,
                        hintText: "비밀번호를 입력해주세요",
                        validator: (input) {
                          if (input.isEmpty) {
                            return "비밀번호를 입력해주세요";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
                        txt: "로그인",
                        txtColor: KwangColor.grey100,
                        bgColor: KwangColor.secondary400,
                        onTap: () async {
                          viewModel.switchIsSubmitted();
                          viewModel.changeLoading(true);
                          viewModel.formKey.currentState!.validate();
                          if (await viewModel.login()) {
                            if (context.mounted) {
                              switch (
                                  await viewModel.getStoreRegisterStatus()) {
                                case StoreRegisterStatus.before:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (_) =>
                                                  RegisterViewModel(),
                                              child: const RegisterView()),
                                    ),
                                  );
                                case StoreRegisterStatus.waiting:
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const WaitingView(),
                                    ),
                                    (route) => false,
                                  );
                                case StoreRegisterStatus.done:
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp(
                                            pageType: PageType.home)),
                                    (route) => false,
                                  );
                              }
                            }
                          } else {
                            showToast("로그인에 실패했습니다");
                          }
                          viewModel.changeLoading(false);
                        },
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                      create: (_) => JoinViewModel(),
                                      child: const JoinView()),
                                ),
                              );
                            },
                            child: Text(
                              "회원가입",
                              style: KwangStyle.body1
                                  .copyWith(color: KwangColor.grey700),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 14,
                            color: KwangColor.grey400,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!await launchUrl(Uri.parse(
                                  dotenv.env['KAKAO_CHANNEL_URL']!))) {
                                throw Exception("URL Error");
                              }
                            },
                            child: Text(
                              "문의하기",
                              style: KwangStyle.body1
                                  .copyWith(color: KwangColor.grey700),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (viewModel.isLoading) const LoadingPage()
            ],
          ),
        ),
      ),
    );
  }
}
