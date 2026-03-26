import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import 'color_config.dart';

String? fontFamily = "CenturyGothic";

var cardShadow = [
  BoxShadow(
    color: ColorConfig.shadowColor,
    spreadRadius: 0.5,
    blurRadius: 10,
    offset: const Offset(0, 5),
  ),
];

ThemeData? theme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorConfig.backgroundColorPrimary,
    primaryColor: ColorConfig.primaryColor,
    fontFamily: fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    shadowColor: ColorConfig.whiteColor.withOpacity(0.4),
    cardTheme: CardTheme(
      color: ColorConfig.whiteColor,
      surfaceTintColor: ColorConfig.whiteColor,
      elevation: 5,
      shadowColor: ColorConfig.whiteColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorConfig.primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return ColorConfig.orangeColor; // Active color
          }
          return ColorConfig.orangeColor; // Inactive color
        },
      ),
    ),

    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(ColorConfig.backgroundColorDark), // Default color
      trackColor: WidgetStateProperty.all(ColorConfig.secondaryColor), // Track color
      trackBorderColor: WidgetStateProperty.all(Colors.grey), // Border color
    ),
  );
}

final defaultPinTheme = PinTheme(
  width: 40,
  height: 40,
  margin: const EdgeInsets.all(2),
  textStyle: const TextStyle(
      fontSize: 20,
      color: ColorConfig.textColorPrimary,
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
// border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(3),
    border: Border.all(
      color: ColorConfig.backgroundColorSecondary,
      width: .7,
    ),
  ),
);

final defaultOTPTheme = PinTheme(
  width: 40,
  height: 40,
  margin: const EdgeInsets.all(2),
  textStyle: const TextStyle(
      fontSize: 20,
      color: ColorConfig.whiteColor,
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
// border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(3),
    border: Border.all(
      color: Colors.transparent,
      width: .7,
    ),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
// border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(3),
  border: Border.all(
    color: ColorConfig.backgroundColorSecondary,
    width: .7,
  ),
);
final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Colors.white,
  ),
);

final defaultPinThemeForPin = PinTheme(
  width: 60.w,
  height: 40,
  textStyle: const TextStyle(
      fontSize: 100,
      color: ColorConfig.whiteColor,
      fontWeight: FontWeight.w200),
  decoration: BoxDecoration(
      borderRadius: null, border: Border.all(color: ColorConfig.textColorPrimary)),
);

final focusedPinThemeForPin = defaultPinTheme.copyWith(
    decoration:
    defaultPinTheme.decoration?.copyWith(borderRadius: null, border: null));

final submittedPinThemeForPin = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration
        ?.copyWith(color: Colors.white, borderRadius: null, border: null));


