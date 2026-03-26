import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/config/color_config.dart';
import 'core/config/router_config.dart';
import 'core/config/size_config.dart';
import 'core/config/theme_config.dart';
import 'features/dashboard/model/response/hive_character_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // optional, usually just portraitUp
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ColorConfig.primaryColor,
    ),
  );

  await ScreenUtil.ensureScreenSize();

  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox<CharacterModel>('characterModelBox');

  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  static _AppRootState of(BuildContext context) {
    return context.findAncestorStateOfType<_AppRootState>()!;
  }

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  Key _providerKey = UniqueKey();

  /// 🔥 CALL THIS ON LOGOUT
  void restartProviders() {
    setState(() {
      _providerKey = UniqueKey(); // destroys all providers
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _providerKey,
      child: const MyApp(),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        SizeConfig.screenHeight = MediaQuery.sizeOf(context).height;
        SizeConfig.screenWidth = MediaQuery.sizeOf(context).width;


        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
          title: 'BS23 Task',
          theme: theme(),
        );
      },
    );
  }
}