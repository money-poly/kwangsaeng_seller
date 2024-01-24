import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/screens/register/register_view_model.dart';
import 'package:kwangsaeng_seller/screens/register/widgets/operating_time_card.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/time_formatter.dart';
import 'package:provider/provider.dart';

enum RegisterBottomSheetType { phone, category, cookingTime, opearatingTime }

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key, required this.type});

  final RegisterBottomSheetType type;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    switch (type) {
      case RegisterBottomSheetType.phone:
        return Container(
          height: 360,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      viewModel.areaNumbers.length,
                      (idx) => GestureDetector(
                        onTap: () {
                          viewModel
                              .updateAreaNumber(viewModel.areaNumbers[idx]);
                          Navigator.of(context).pop();
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          margin: idx == viewModel.areaNumbers.length - 1
                              ? const EdgeInsets.only(bottom: 20)
                              : const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(viewModel.areaNumbers[idx],
                                    style: KwangStyle.btn1SB),
                              ),
                              if (viewModel.areaNumbers[idx] ==
                                  viewModel.selectedAreaNumber)
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
                ),
              ),
            ],
          ),
        );
      case RegisterBottomSheetType.category:
        return Container(
          height: 52 * viewModel.categories.length + 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: KwangColor.grey300,
                ),
              ),
              Column(
                children: List.generate(
                  viewModel.isSelectedCategory.length,
                  (idx) => GestureDetector(
                    onTap: () {
                      viewModel.updateSelectedCategories(idx);
                      viewModel.checkValidCategory();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(viewModel.categories[idx].name,
                              style: KwangStyle.btn1SB.copyWith(
                                  color: viewModel.isSelectedCategory[idx]
                                      ? KwangColor.grey900
                                      : KwangColor.grey600)),
                          SvgPicture.asset(
                            "assets/icons/ic_24_check_${viewModel.isSelectedCategory[idx] ? "fill" : "line"}.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                viewModel.isSelectedCategory[idx]
                                    ? KwangColor.secondary400
                                    : KwangColor.grey600,
                                BlendMode.srcIn),
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
      case RegisterBottomSheetType.cookingTime:
        return Container(
          height: 360,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: KwangColor.grey300,
                ),
              ),
              SizedBox(
                height: 300,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: viewModel.cookingTime),
                  itemExtent: 28,
                  magnification: 1.8,
                  squeeze: 1,
                  useMagnifier: true,
                  onSelectedItemChanged: (selected) {
                    viewModel.updateCookingTime(selected);
                  },
                  children: List.generate(
                    61,
                    (idx) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(idx.toString(), style: KwangStyle.body1M),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case RegisterBottomSheetType.opearatingTime:
        return Container(
          height: 420,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: KwangColor.grey300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.updateSelectTime(TimeType.open);
                      },
                      child: OperatingTimeCard(
                          title: "영업 시작",
                          time: timeFormatter(
                              viewModel.openTime, TimeFormat.timeToKorStr),
                          isSelected: viewModel.selectedTime == TimeType.open),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        viewModel.updateSelectTime(TimeType.close);
                      },
                      child: OperatingTimeCard(
                          title: "영업 종료",
                          time: timeFormatter(
                              viewModel.closeTime, TimeFormat.timeToKorStr),
                          isSelected: viewModel.selectedTime == TimeType.close),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: viewModel.selectedTime == TimeType.open
                    ? CupertinoDatePicker(
                        key: const Key("openTime"),
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (time) {
                          viewModel.updateOpenTime(
                              TimeOfDay(hour: time.hour, minute: time.minute));
                          viewModel.checkValidOperationTime();
                        },
                        initialDateTime: DateTime(2023, 4, 29,
                            viewModel.openTime.hour, viewModel.openTime.minute),
                      )
                    : CupertinoDatePicker(
                        key: const Key("closeTime"),
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (time) {
                          viewModel.updateCloseTime(
                              TimeOfDay(hour: time.hour, minute: time.minute));
                          viewModel.checkValidOperationTime();
                        },
                        initialDateTime: DateTime(
                            2023,
                            4,
                            29,
                            viewModel.closeTime.hour,
                            viewModel.closeTime.minute),
                      ),
              ),
            ],
          ),
        );
    }
  }
}
