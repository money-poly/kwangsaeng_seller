import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/main.dart';
import 'package:kwangsaeng_seller/screens/home/home_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/screens/setting/widgets/setting_btn.dart';
import 'package:kwangsaeng_seller/screens/store/store_modify_view.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingMainView extends StatelessWidget {
  const SettingMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homeViewModel.store!.category,
                        style: KwangStyle.body2M
                            .copyWith(color: KwangColor.grey600),
                      ),
                      const SizedBox(height: 2),
                      Text(homeViewModel.store!.name,
                          style: KwangStyle.header1),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) =>
                                    RegisterViewModel(StoreUpdateViewType.edit),
                                child: const StoreModifyView(),
                              ),
                            ),
                          );
                          homeViewModel.init();
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: KwangColor.grey400, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text("정보 수정",
                                  style: KwangStyle.body2M
                                      .copyWith(color: KwangColor.grey700)),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                "assets/icons/ic_16_edit.svg",
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                    KwangColor.grey700, BlendMode.srcIn),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SettingBtn(
                title: "비밀번호 변경",
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse(dotenv.env['KAKAO_CHANNEL_URL']!))) {
                    throw Exception("URL Error");
                  }
                }),
            SettingBtn(
                title: "고객센터",
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse(dotenv.env['KAKAO_CHANNEL_URL']!))) {
                    throw Exception("URL Error");
                  }
                }),
            SettingBtn(
                title: "서비스 이용약관",
                onTap: () async {
                  if (!await launchUrl(Uri.parse(dotenv.env['TERMS_URL']!))) {
                    throw Exception("URL Error");
                  }
                }),
            SettingBtn(
                title: "로그아웃",
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: "로그아웃 하시겠습니까?",
                      content: "로그아웃 시 로그인 화면으로 이동합니다.",
                      onCanceled: () {
                        Navigator.pop(context);
                      },
                      onConfirmed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear().then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MyApp(pageType: PageType.start),
                                  ),
                                  (route) => false),
                            );
                      },
                    ),
                  );
                },
                icon: false),
          ],
        ),
      ),
    );
  }
}
