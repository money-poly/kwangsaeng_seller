import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

enum EmptyCardType {
  menu("등록된 메뉴가 없어요!", "우리 가게의 메뉴를 등록해주세요!");

  const EmptyCardType(this.title, this.description);
  final String title;
  final String description;
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key, required this.emptyType});

  final EmptyCardType emptyType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Image.asset(
          "assets/imgs/img_86_bird_exclamation.png",
          width: 86,
          height: 86,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                emptyType.title,
                style: KwangStyle.header2,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                emptyType.description,
                style: KwangStyle.btn1SB.copyWith(color: KwangColor.grey600),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
