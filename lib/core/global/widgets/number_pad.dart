
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/color_config.dart';
import 'common_widgets.dart';


class CustomNumberPad extends StatelessWidget {
  final VoidCallback? onNextClick;
  final Function(String) onKeyPress;
  double? horizontalSpace;
  double? verticalSpace;
  bool? isFromNFC;
  Color nextButtonColor;


  CustomNumberPad(
      {super.key,
        required this.onKeyPress,
        this.onNextClick,
        this.horizontalSpace,
        this.verticalSpace,
        this.isFromNFC = false,
        this.nextButtonColor = ColorConfig.greenColor});

  var textStyle = TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w500,
      color: ColorConfig.whiteColor);

  @override
  Widget build(BuildContext context) {
    return glassView(
      child: Container(
        decoration: BoxDecoration(
            color: ColorConfig.transparentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.sp),
              topRight: Radius.circular(24.sp),
            )
        ),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: horizontalSpace ?? 24.w, vertical: verticalSpace ?? 24.h),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWidget(row1: "1", row2: "2", row3: "3"),
              SizedBox(height: verticalSpace ?? 20),
              _buildWidget(row1: "4", row2: "5", row3: "6"),
              SizedBox(height: verticalSpace ?? 20),
              _buildWidget(row1: "7", row2: "8", row3: "9"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Call a function to handle the backspace button click
                      onKeyPress("<");
                    },
                    child: glassView(
                    opacity: 0.5,
                    color: ColorConfig.blackColor,
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        child: Center(
                          child: Icon(
                            Icons.backspace_outlined,
                            color: ColorConfig.whiteColor,
                            size: 28.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      onKeyPress("0");
                    },
                    child: glassView(
                      opacity: 0.5,
                      color: ColorConfig.blackColor,
                      child: Container(
                          width: 48.w,
                          height: 48.h,
                          alignment: Alignment.center,
                          child: Text(
                            "0",
                            style: textStyle,
                          )),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      onNextClick?.call();
                    },
                    child: glassView(
                      opacity: 0.5,
                      color: nextButtonColor,
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        child:  Center(
                          child: Icon(Icons.arrow_forward, color: nextButtonColor, size: 18.sp,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5)
            ]),
      ),
    );
  }

  Widget _buildWidget({
    required String row1,
    required String row2,
    required String row3,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () {
          onKeyPress(row1);
        },
        child: glassView(
          opacity: 0.5,
          color: ColorConfig.blackColor,
          child: Container(
              width: 48.w,
              height: 48.h,
              alignment: Alignment.center,
              child: Text(
                row1,
                style: textStyle,
              )),
        ),
      ),
      InkWell(
        onTap: () {
          onKeyPress(row2);
        },
        child: glassView(
          opacity: 0.5,
          color: ColorConfig.blackColor,
          child: Container(
              width: 48.w,
              height: 48.h,
              alignment: Alignment.center,
              child: Text(
                row2,
                style: textStyle,
              )),
        ),
      ),
      InkWell(
        onTap: () {
          onKeyPress(row3);
        },
        child: glassView(
          opacity: 0.5,
          color: ColorConfig.blackColor,
          child: Container(
              width: 48.w,
              height: 48.h,
              alignment: Alignment.center,
              child: Text(
                row3,
                style: textStyle,
              )),
        ),
      )
    ]);
  }

  static BoxDecoration get outlineGray10001 => BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 1,
    ),
  );
}
