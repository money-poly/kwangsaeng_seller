import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';

class ImgUploadCard extends StatelessWidget {
  const ImgUploadCard({super.key, required this.imgUrl});

  final String? imgUrl;
  @override
  Widget build(BuildContext context) {
    switch (imgUrl) {
      case null:
        return Container(
          margin: const EdgeInsets.only(top: 8, right: 8),
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: KwangColor.grey400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/ic_24_camera_fill.svg",
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(KwangColor.grey600, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              Text(
                "사진 업로드",
                style: KwangStyle.body2M.copyWith(color: KwangColor.grey500),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(
                imgUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
    }
  }
}
