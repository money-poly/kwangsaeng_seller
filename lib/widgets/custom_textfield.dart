import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class CustomTextField extends StatefulWidget {
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
    this.readOnly = false,
    this.icon,
    this.prompt,
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
  final bool readOnly;
  final Widget? icon;
  final String? prompt;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            TextFormField(
              controller: widget.controller,
              validator: (value) {
                isValidated = true;
                return widget.validator(value) == null ? null : "";
              },
              onChanged: (value) => setState(() {
                isValidated = true;
              }),
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              obscureText: widget.isObsecure,
              readOnly: widget.readOnly,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: KwangStyle.body1,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: KwangStyle.body1.copyWith(color: KwangColor.grey600),
                errorStyle: KwangStyle.body2.copyWith(color: KwangColor.red),
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                suffixIcon: widget.icon,
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 34,
                  maxHeight: 18,
                ),
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
            if (isValidated && widget.validator(widget.controller.text) != null)
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.validator(widget.controller.text)!,
                        style: KwangStyle.body2.copyWith(color: KwangColor.red),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (widget.prompt != null &&
            !(isValidated && widget.validator(widget.controller.text) != null))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.prompt!,
                  style: KwangStyle.body2.copyWith(color: KwangColor.grey700),
                ),
              ],
            ),
          ),
        if (widget.isVisibleMaxLength)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${widget.controller.text.length}자",
                  style: KwangStyle.body1,
                ),
                const SizedBox(width: 4),
                Text(
                  "/${widget.maxLength}자",
                  style: KwangStyle.body1.copyWith(color: KwangColor.grey700),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
