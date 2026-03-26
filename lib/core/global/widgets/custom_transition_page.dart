import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  int durationMilliseconds = 500,
  AppTransitionType transitionType = AppTransitionType.slideFromRight,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration(milliseconds: durationMilliseconds),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case AppTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case AppTransitionType.slideFromLeft:
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
            child: child,
          );

        case AppTransitionType.slideFromBottom:
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
            child: child,
          );

        case AppTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);

        case AppTransitionType.slideFromRight:
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          );

        // default:
        //   return SlideTransition(
        //     position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
        //     child: child,
        //   );
      }
    },
  );
}


enum AppTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  scale,
}
