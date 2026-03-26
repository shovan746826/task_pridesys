import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/color_config.dart';


PreferredSizeWidget? GlobalAppBar({
  String? title,
  Color titleColor = ColorConfig.textColorDark,
  TitleAlignment titleAlignment = TitleAlignment.center,
  FontWeight? titleFontWeight = FontWeight.normal,
  Color iconThemeColor = Colors.white,
  Color backgroundColor = Colors.transparent,
  Widget customIcon = const SizedBox.shrink(),
  Function? onBackPressed,
}){
  return AppBar(
    backgroundColor: backgroundColor,
    // shape: Border(
    //   bottom: BorderSide(
    //     color: ColorConfig.broderColor, // Line color
    //     width: 2,           // Line height
    //   ),
    // ),
    iconTheme: IconThemeData(color: iconThemeColor),
    leading: Navigator.canPop(Get.context!)
        ? GestureDetector(
      onTap: () => onBackPressed ?? Navigator.pop(Get.context!),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: iconThemeColor,
          size: 20,
        ),
      ),
    ) : null,
    actions: [
      titleAlignment ==  TitleAlignment.center ?
      const Spacer() : Navigator.canPop(Get.context!) ? SizedBox(width: 48.w,) : SizedBox(width: 12.w,),

      Text(title ?? "",
          style: TextStyle(
            fontSize: 16.sp,
            color: titleColor,
            fontWeight: titleFontWeight,
          )
      ),

      const Spacer(),

      customIcon,
    ],
  );
}

enum TitleAlignment {
  left,
  center,
}