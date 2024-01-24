import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/join/join_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:provider/provider.dart';

class EmailBottomSheet extends StatelessWidget {
  const EmailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Container(
      height: 64 * viewModel.domains.length + 48,
      padding: const EdgeInsets.fromLTRB(20, 0, 16, 40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: KwangColor.grey100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            width: 44,
            height: 6,
            decoration: BoxDecoration(
              color: KwangColor.grey300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Column(
            children: List.generate(
              viewModel.domains.length,
              (idx) => GestureDetector(
                onTap: () {
                  viewModel.selectDomain(viewModel.domains[idx]);
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  margin: idx == viewModel.domains.length - 1
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(viewModel.domains[idx],
                            style: KwangStyle.btn1SB),
                      ),
                      if (viewModel.domains[idx] == viewModel.selDomain)
                        SvgPicture.asset(
                          "assets/icons/ic_36_check.svg",
                          width: 36,
                          height: 36,
                          colorFilter: const ColorFilter.mode(
                              KwangColor.secondary400, BlendMode.srcIn),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
