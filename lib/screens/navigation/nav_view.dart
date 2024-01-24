import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/navigation/nav_view_model.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:provider/provider.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NavViewModel>(context);
    return Scaffold(
      body: viewModel.currPages,
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        color: KwangColor.grey100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: NavItems.values
              .map(
                (item) => Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      viewModel.changeIdx(item.index);
                    },
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.only(bottom: 8, top: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset(
                                "assets/icons/ic_24_${item.name}.svg",
                                width: 26,
                                height: 26,
                                colorFilter: ColorFilter.mode(
                                    item.index == viewModel.currIdx
                                        ? KwangColor.secondary400
                                        : KwangColor.grey500,
                                    BlendMode.srcIn)),
                          ),
                          Text(item.label,
                              style: KwangStyle.navigationLabel.copyWith(
                                  color: item.index == viewModel.currIdx
                                      ? KwangColor.secondary400
                                      : KwangColor.grey500)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
