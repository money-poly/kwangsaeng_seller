import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/styles/color.dart';

class KwangStyle {
  static const TextStyle base = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: KwangColor.grey900,
    leadingDistribution: TextLeadingDistribution.even,
  );
  
  static final TextStyle header = base.copyWith(fontWeight: FontWeight.w700);
  static final TextStyle header0 = header.copyWith(fontSize: 26, height: 36 / 26);
  static final TextStyle header1 = header.copyWith(fontSize: 20, height: 32 / 20);
  static final TextStyle header2 = header.copyWith(fontSize: 18, height: 24 / 18);
  static final TextStyle header3 = header.copyWith(fontSize: 16, height: 20 / 16);

  static final TextStyle btn1 = base.copyWith(fontSize: 16, height: 20 / 16);
  static final TextStyle btn1B = btn1.copyWith(fontWeight: FontWeight.w700);
  static final TextStyle btn1SB = btn1.copyWith(fontWeight: FontWeight.w600);

  static final TextStyle btn2 = base.copyWith(fontSize: 14, height: 20 / 14);
  static final TextStyle btn2B = btn2.copyWith(fontWeight: FontWeight.w700);
  static final TextStyle btn2SB = btn2.copyWith(fontWeight: FontWeight.w600);

  static final TextStyle btn3 = base.copyWith(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w700);
  
  static final TextStyle body1 = base.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w400);
  static final TextStyle body1M = body1.copyWith(fontWeight: FontWeight.w500);
  
  static final TextStyle body2 = base.copyWith(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w400);
  static final TextStyle body2M = body2.copyWith(fontWeight: FontWeight.w500);

  static final TextStyle body3 = base.copyWith(fontSize: 10, height: 14 / 10, fontWeight: FontWeight.w400);
  static final TextStyle body3M = body3.copyWith(fontWeight: FontWeight.w500);

  static final TextStyle paragraph = base.copyWith(fontSize: 14, height: 24 / 14, fontWeight: FontWeight.w400, letterSpacing: -0.5);

  static final TextStyle navigationLabel = base.copyWith(fontSize: 10, height: 12 / 10, fontWeight: FontWeight.w700);
  static final TextStyle appBarBase = base.copyWith(fontFamily: "Sejong", fontWeight: FontWeight.w700, leadingDistribution: TextLeadingDistribution.even);
  static final TextStyle appBar1 = appBarBase.copyWith(fontSize: 20, textBaseline: TextBaseline.alphabetic);
  static final TextStyle appBar2 = appBarBase.copyWith(fontSize: 18);
}