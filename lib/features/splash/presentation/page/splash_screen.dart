import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/config/size_config.dart';
import '../../../../core/global/widgets/app_background_view.dart';
import '../../provider/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    ref.read(splashControllerProvider(context)).setOnboarding(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BackgroundView(
      child: Center(
        child: SizedBox(
          width: SizeConfig.screenWidth!.h,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 48.sp,
              fontFamily: 'Canterbury',
            ),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 100),
              repeatForever: false,
              isRepeatingAnimation: false,
              animatedTexts: [
                ScaleAnimatedText('Pridesys',
                  textAlign: TextAlign.center,
                  duration: const Duration(milliseconds: 500),
                ),
                WavyAnimatedText('Pridesys',
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 200),),
              ],
              onTap: () {

              },
            ),
          ),
        ).paddingSymmetric(horizontal: 24.w),
      ),
    );
  }
}
