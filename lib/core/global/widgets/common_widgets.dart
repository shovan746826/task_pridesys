import 'dart:math';
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/color_config.dart';

Widget dottedLine({double height = 1, double width = 1, Color color = Colors.black}){
  return  DottedLine(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    lineLength: double.infinity,
    lineThickness: 1.0,
    dashLength: 4.0,
    dashColor: ColorConfig.greyColor,
    // dashGradient: [Colors.red, Colors.blue],
    dashRadius: 0.0,
    dashGapLength: 4.0,
    dashGapColor: ColorConfig.transparentColor,
    // dashGapGradient: [Colors.red, Colors.blue],
    dashGapRadius: 0.0,
  );
}

Widget customAvatarByName(String name, {double size = 80}){
  return Center(
    child: Initicon(
      text: name,
      size: size,
      borderRadius: BorderRadius.circular(100),
      backgroundColor: getRandomColor(),
      style: TextStyle(
        color: Colors.white,
        fontSize: size * 0.45,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

Widget glassView({
  required Widget child,
  double blur = 15,
  double opacity = 0.1,
  double borderRadius = 16,
  Color color = Colors.white,
  EdgeInsetsGeometry padding = const EdgeInsets.all(8),
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: color.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    ),
  );
}