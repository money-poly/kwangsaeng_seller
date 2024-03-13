import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/custom_textfield.dart';
import 'package:kwangsaeng_seller/widgets/textfield_title.dart';

class MenuPriceTextFields extends StatelessWidget {
  const MenuPriceTextFields({super.key, required this.viewModel});

  final MenuUpdateViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldTitle(title: "정가"),
                      CustomTextField(
                        controller: viewModel.regularPriceController,
                        hintText: "0",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (viewModel.areValidatedPrices &&
                              !viewModel.areValidPrices) {
                            return "";
                          }
                          return null;
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            "원",
                            style: KwangStyle.body1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldTitle(title: "판매가"),
                      CustomTextField(
                        controller: viewModel.discountPriceController,
                        hintText: "0",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (viewModel.areValidatedPrices &&
                              !viewModel.areValidPrices) {
                            return "";
                          }
                          return null;
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            "원",
                            style: KwangStyle.body1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (viewModel.areValidatedPrices && !viewModel.areValidPrices)
              Positioned(
                bottom: 0,
                left: 0,
                child: Text(
                    !viewModel.arePricesNotEmpty()
                        ? "가격을 입력해주세요"
                        : "판매가가 정가보다 작아야합니다.",
                    style: KwangStyle.body2.copyWith(color: KwangColor.red)),
              )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "현재 ",
              style: KwangStyle.body2.copyWith(color: KwangColor.grey700),
            ),
            Text(
              "${viewModel.discountRate.toStringAsFixed(1)}% ",
              style: KwangStyle.body2M.copyWith(color: KwangColor.red),
            ),
            Text(
              "할인",
              style: KwangStyle.body2.copyWith(color: KwangColor.grey700),
            )
          ],
        ),
      ],
    );
  }
}
