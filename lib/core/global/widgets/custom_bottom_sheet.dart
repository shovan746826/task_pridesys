import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/color_config.dart';

class CustomBottomSheet {

  static showSheet(BuildContext context, Widget widget, {double? height, Decoration? backgroundDecoration, bool? isDismissible, Function()? onSheetCloseCallBack}) async{
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: isDismissible ?? true,
        isDismissible: isDismissible ?? true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        context: context,
        builder: (context) {
          return Container(
             height: height,
              decoration: backgroundDecoration ??  BoxDecoration(
                color: ColorConfig.backgroundColorPrimary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.sp),
                  topLeft: Radius.circular(12.sp),
                ),
              ),

              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Column(
                children: [
                  Container(
                    height: 4.sp,
                    width: 32.sp,
                    margin: EdgeInsets.only(bottom: 16.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                  ),
                  widget,
                ],
              )
          );
        });

    onSheetCloseCallBack?.call();
  }



}
