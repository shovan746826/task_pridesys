import 'package:task/core/global/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_config.dart';
import '../../config/size_config.dart';

class CommonListShimmer extends StatelessWidget {
  const CommonListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConfig.greyLightColor,
      highlightColor: ColorConfig.transparentColor,
      child: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index) {
            return glassView(
              borderRadius: 8.r,
              child: Container(
                height: 72.h,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: ColorConfig.transparentColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(11.0)),
                    child: Container(),
                  ),
                ),
              ),
            ).marginOnly(bottom: 8.h);
          },
        ),
      ),
    );;
  }
}
