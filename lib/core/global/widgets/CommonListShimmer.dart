import 'package:task/core/global/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_config.dart';

class CommonListShimmer extends StatelessWidget {
  const CommonListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConfig.greyLightColor,
      highlightColor: Colors.grey.shade300, // better than transparent
      child: GridView.builder(
        padding: EdgeInsets.all(8.w),
        itemCount: 12, // number of shimmer items
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: .6,
        ),
        itemBuilder: (_, index) {
          return glassView(
            borderRadius: 8.r,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Title placeholder
                  Container(
                    height: 10.h,
                    width: 60.w,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    color: Colors.grey,
                  ),

                  SizedBox(height: 4.h),

                  // Subtitle placeholder
                  Container(
                    height: 10.h,
                    width: 40.w,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
