import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_btn.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Image.asset("assets/imgs/img_280_congratulations.png",
                  width: 280),
              const SizedBox(height: 24),
              Text(
                "사장님의 가게를\n등록하고 있습니다!",
                style: KwangStyle.header1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "승인이 완료되면 입력하신 휴대폰 번호로 알림이 전송됩니다.\n알림을 받으신 뒤 부터 광생 서비스 이용이 가능합니다.",
                style: KwangStyle.body2M.copyWith(color: KwangColor.grey700),
                textAlign: TextAlign.center,
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 16, 20, 16 + MediaQuery.of(context).padding.bottom),
        child: CustomBtn(
          txt: "종료",
          txtColor: KwangColor.grey100,
          bgColor: KwangColor.secondary400,
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ),
      ),
    );
  }
}
