import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/router_config.dart';
import '../../../core/global/global_features/controller/base_controller.dart';
import '../../../core/global/util/shared_preferences.dart';



class SplashController extends BaseController {
  BuildContext context;

  SplashController({required this.context});

  setOnboarding(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 3));
    context.pushReplacement(RouterPath.dashboardScreenPath);
    notifyListeners();
  }




}