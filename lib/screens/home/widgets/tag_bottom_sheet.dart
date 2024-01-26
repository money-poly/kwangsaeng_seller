import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/home/home_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/widgets/tag_widget.dart';
import 'package:provider/provider.dart';

class TagBottomSheet extends StatelessWidget {
  const TagBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Container(
      height: 64 * viewModel.tags.length + 12 * viewModel.tags.length + 60,
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
              viewModel.tags.length,
              (idx) => GestureDetector(
                onTap: () {
                  viewModel.selectTag(viewModel.tags[idx].id);
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  margin: idx == viewModel.tags.length - 1
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(viewModel.tags[idx].name,
                                    style: KwangStyle.btn1SB),
                                const SizedBox(width: 8),
                                TagWidget(tag: viewModel.tags[idx])
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              viewModel.tags[idx].description,
                              style: KwangStyle.body1M
                                  .copyWith(color: KwangColor.grey600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (viewModel.tags[idx].id == viewModel.selectedTag)
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
