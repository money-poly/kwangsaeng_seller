import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.maxLength,
    this.isObsecure = false,
    this.isVisibleMaxLength = false,
    this.currLength = 0,
  });

  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final bool isObsecure;
  final bool isVisibleMaxLength;
  final int currLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          obscureText: isObsecure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: KwangStyle.body1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: KwangStyle.body1.copyWith(color: KwangColor.grey600),
            errorStyle: KwangStyle.body2.copyWith(color: KwangColor.red),
            counterText: "",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: KwangColor.grey400,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: KwangColor.grey400,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: KwangColor.secondary400,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: KwangColor.red,
                width: 1,
              ),
            ),
          ),
        ),
        if (isVisibleMaxLength)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${controller.text.length}자",
                  style: KwangStyle.body1,
                ),
                const SizedBox(width: 4),
                Text(
                  "/$maxLength자",
                  style: KwangStyle.body1.copyWith(color: KwangColor.grey700),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
