import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/color_config.dart';
import '../../config/size_config.dart';
import '../util/global_function.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.btnText,
    this.enableIconOnlyBtn = Icons.navigate_next_rounded,
    required this.onPressed,
    this.isPrimaryButton = true,
    this.btnTextSize = 16,
    this.btnColor,
    this.btnTextColor,
    this.btnHeight = 48,
    this.btnWidth,
    this.btnTextStyle,
    this.btnMarginHorizontal = 0,
    this.btnMarginVertical = 0,
    this.btnBorderRadius = 16,
    this.btnOpacity = 1.0,
    this.borderColor,
    this.borderWidth = 1,
  });

  final String btnText;
  final IconData enableIconOnlyBtn;
  final VoidCallback? onPressed;
  final bool isPrimaryButton;
  final double? btnTextSize;
  final Color? btnColor;
  final Color? btnTextColor;
  final double? btnHeight;
  final double? btnWidth;
  final TextStyle? btnTextStyle;
  final double btnBorderRadius;
  final double btnMarginHorizontal;
  final double btnMarginVertical;
  final double btnOpacity;

  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: btnOpacity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor:
          btnColor ?? ColorConfig.whiteColor.withValues(alpha: 0.5),
          highlightColor:
          btnColor ?? ColorConfig.greyColor.withValues(alpha: 1.0),
          borderRadius: BorderRadius.circular(btnBorderRadius),
          onTap: () async {
            await debounceTap(context, onPressed);
          },
          child: Container(
            height: btnHeight ?? 48.h,
            width: btnWidth ?? SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(
              horizontal: btnMarginHorizontal,
              vertical: btnMarginVertical,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(btnBorderRadius),
              color: btnColor ?? ColorConfig.primaryColor,
              gradient: btnColor != null
                  ? null
                  : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isPrimaryButton
                      ? [
                    ColorConfig.backgroundColorDark,
                    ColorConfig.primaryColor,
                    ColorConfig.secondaryColor
                  ]
                      : [
                    (btnColor ?? ColorConfig.whiteColor),
                    (btnColor ?? ColorConfig.greyLightColor)
                  ]),
              border: Border.all(
                width: borderWidth ?? 1,
                color: borderColor ??
                    (isPrimaryButton
                        ? ColorConfig.primaryColor
                        : ColorConfig.blackColor),
              ),
            ),
            child: Center(
              child: btnText.isEmpty
                  ? Icon(enableIconOnlyBtn,
                  size: 35, color: ColorConfig.whiteColor)
                  : Text(
                btnText,
                style: btnTextStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: btnTextColor ??
                          (isPrimaryButton
                              ? ColorConfig.whiteColor
                              : ColorConfig.textColorSecondary),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButtonOuter extends StatelessWidget {
  const PrimaryButtonOuter({
    super.key,
    required this.btnText,
    this.enableIconOnlyBtn = Icons.navigate_next_rounded,
    required this.onPressed,
    this.isPrimaryButton = true,
    this.btnTextSize = 16,
    this.btnColor,
    this.btnTextColor,
    this.btnHeight = 55,
    this.btnWidth,
    this.btnTextStyle,
    this.btnMarginHorizontal = 0,
    this.btnMarginVertical = 0,
    this.btnBorderRadius = 50,
    this.btnOpacity = 1.0,
  });

  final String btnText;
  final IconData enableIconOnlyBtn;
  final VoidCallback? onPressed;
  final bool isPrimaryButton;
  final double btnTextSize;
  final Color? btnColor;
  final Color? btnTextColor;
  final double? btnHeight;
  final double? btnWidth;
  final TextStyle? btnTextStyle;
  final double btnBorderRadius;
  final double btnMarginHorizontal;
  final double btnMarginVertical;
  final double btnOpacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: btnOpacity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor:
          btnColor ?? ColorConfig.whiteColor.withValues(alpha: 0.5),
          highlightColor:
          btnColor ?? ColorConfig.greyColor.withValues(alpha: 1.0),
          borderRadius: BorderRadius.circular(btnBorderRadius),
          onTap: onPressed,
          child: Container(
            height: btnHeight ?? 48.h,
            width: btnWidth ?? SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(
              horizontal: btnMarginHorizontal,
              vertical: btnMarginVertical,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(btnBorderRadius),
              color: ColorConfig.transparentColor,
              border: Border.all(
                width: 1,
                color: isPrimaryButton
                    ? ColorConfig.primaryColor
                    : ColorConfig.secondaryColor,
              ),
            ),
            child: Center(
              child: btnText.isEmpty
                  ? Icon(enableIconOnlyBtn,
                  size: 35, color: ColorConfig.whiteColor)
                  : Text(
                btnText,
                style: btnTextStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: btnTextColor ??
                          (isPrimaryButton
                              ? ColorConfig.whiteColor
                              : ColorConfig.textColorSecondary),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
