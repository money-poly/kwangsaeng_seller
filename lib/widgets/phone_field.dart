import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';
import 'package:provider/provider.dart';

import '../screens/register/widgets/register_bottom_sheet.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.viewModel});

  final RegisterViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldTitle(title: "업체 전화번호"),
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ChangeNotifierProvider.value(
                        value: viewModel,
                        child: const RegisterBottomSheet(
                          type: RegisterBottomSheetType.phone,
                        ),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    alignment: Alignment.center,
                    width: 64,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: !viewModel.isPhoneValidated ||
                                  viewModel.isValidPhone
                              ? KwangColor.grey400
                              : KwangColor.red,
                          width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.selectedAreaNumber,
                          style: KwangStyle.body1
                              .copyWith(color: KwangColor.grey900),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          "assets/icons/ic_16_dropdown.svg",
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                              KwangColor.grey700, BlendMode.srcIn),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextField(
                    controller: viewModel.phoneController,
                    hintText: "-없이 숫자만 입력해주세요",
                    validator: (input) {
                      if (!viewModel.isValidPhone) {
                        return "";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
                  ),
                )
              ],
            ),
            if (viewModel.isPhoneValidated && !viewModel.isValidPhone)
              Positioned(
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "올바른 전화번호를 입력해주세요",
                        style: KwangStyle.body2.copyWith(color: KwangColor.red),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
