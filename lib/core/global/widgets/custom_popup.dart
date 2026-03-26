
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../config/asset_config.dart';
import '../../config/color_config.dart';

class CustomAlertPopUp {
  static void showLoadingDialog({required BuildContext context,
    String title = "Processing is going on...",
    String description = "Please wait, Processing..."}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0XFFf1f2f3),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding:
          const EdgeInsets.symmetric(horizontal: 25, vertical: 220),

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorConfig.textColorPrimary,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: (1.0).h,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: (96).h,
                          width: (96).w,
                          child: Lottie.asset(AssetConfig.loadingAnimationAssetJson)),
                      // SizedBox(
                      //   height: (70).h,
                      //   width: (70).w,
                      //   child:
                      //   Image.asset(AssetConfig.loadingAnimationAssetGif),
                      // ),
                    ),

                    SizedBox(
                      height: (10.0).h,
                    ),
                    Text(description,
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConfig.textColorPrimary,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis),

                    SizedBox(
                      height: (15.0).h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  static void hideLoadingDialog({required BuildContext context}) {
    context.pop();
  }
}