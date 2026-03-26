import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/asset_config.dart';
import '../../config/color_config.dart';
import '../../config/size_config.dart';


Widget BackgroundView({required Widget child, blurEffect = false}){
  return Stack(
    children: [
      Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConfig.bg),
            fit: BoxFit.cover,
          ),
        ),
      ),

      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50), // adjust blur intensity
          child: Container(
            color: ColorConfig.backgroundGradientColor_2.withAlpha(30), // optional overlay color
          ),
        ),
      ),

      child,
    ],
  );
}