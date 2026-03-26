import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/splash_controller.dart';

splashControllerProvider(BuildContext context) => Provider.autoDispose<SplashController>((ref) => SplashController(context: context));