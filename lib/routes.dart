import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/SecondPage.dart';
import 'package:sample/loading_dialog.dart';
import 'package:sample/main.dart';

final ValueNotifier<RoutingConfig> appRoutingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    routes: routeBase,
  ),
);

final List<RouteBase> routeBase = <RouteBase>[
  GoRoute(
    path: MyHomePage.routePath,
    builder: (_, __) => const MyHomePage(),
  ),
  GoRoute(
    path: SecondPage.routePath,
    builder: (_, __) => const SecondPage(),
  ),
  GoRoute(
    path: LoadingDialog.routePath,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return DialogPage<void>(builder: (BuildContext context) {
        return const LoadingDialog();
      });
    },
  ),
  GoRoute(
    path: LoadingDialog.routePathWithParam,
    pageBuilder: (BuildContext context, GoRouterState state) {
      final text = state.extra as String;
      return DialogPage<void>(builder: (BuildContext context) {
        return LoadingDialog(
          text: text,
        );
      });
    },
  ),
];

GoRouter getGlobalRouter(String initialRoute) {
  final GoRouter router = GoRouter.routingConfig(
    initialLocation: initialRoute,
    routingConfig: appRoutingConfig,
    navigatorKey: NavigationService.navigatorKey,
    observers: <NavigatorObserver>[
      AppNavigatorObserver(),
    ],
  );
  return router;
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    try {
      log('didPush: is Page ${route.settings is Page<void>}');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    return;
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    return;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    return;
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    return;
  }

  @override
  void didStopUserGesture() {
    return;
  }
}

class DialogPage<T> extends Page<T> {
  const DialogPage({required WidgetBuilder builder}) : _builder = builder;

  final WidgetBuilder _builder;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      builder: _builder,
      barrierDismissible: false,
      barrierColor: Colors.black26,
    );
  }
}
