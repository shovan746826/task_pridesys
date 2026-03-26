import 'package:task/features/dashboard/presentation/page/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/model/response/hive_character_model.dart';
import '../../features/dashboard/presentation/page/details_screen.dart';
import '../../features/splash/presentation/page/splash_screen.dart';
import '../global/widgets/custom_transition_page.dart';


const String splashScreen = "/splashScreen";

const String dashboardScreen = "/dashboardScreen";
const String detailsScreen = "/detailsScreen";




var goRouter = GoRouter(
    navigatorKey: Get.key,
    debugLogDiagnostics: true,
    initialLocation: splashScreen,
    routes: [
      GoRoute(
          path: splashScreen,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            transitionType: AppTransitionType.fade, // 👈 fade for splash
            child: SplashScreen(),
          ),
      ),


      GoRoute(
          path: dashboardScreen,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: DashboardScreen(),
          ),
        routes: [
          GoRoute(
              path: detailsScreen,
              pageBuilder: (context, state) {
                final item = state.extra as CharacterModel;
                return buildPageWithTransition(
                  context: context,
                  state: state,
                  child: DetailsScreen(item: item,),
                );
              },
          ),
        ]
      ),

    ]
);

class RouterPath {
  static const String splashScreenPath = splashScreen;
  static const String dashboardScreenPath = dashboardScreen;
  static const String detailsScreenPath = "$dashboardScreen$detailsScreen";

}