import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/pages/paths.dart';
import 'package:spacirtrasa/widgets/bottom_bar_frame.dart';

import '../pages/home.dart';
import '../pages/interests.dart';
import '../pages/login.dart';
import '../pages/profile.dart';
import '../pages/village.dart';

class RouteService {
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _shellNavKey = GlobalKey<NavigatorState>();
  static final log = Logger();

  static final router = GoRouter(
    initialLocation: LoginPage.route,
    navigatorKey: _rootNavKey,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavKey,
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),

      ShellRoute(
        navigatorKey: _shellNavKey,
        pageBuilder: (context, state, child) {
          log.d("Shell route: ${state.matchedLocation}");
          return NoTransitionPage(
            child: BottomBarFrame(location: state.matchedLocation, child: child),
          );
        },
        routes: [
          GoRoute(
            path: HomePage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: PathsPage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: PathsPage()),
          ),
          GoRoute(
            path: InterestsPage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: InterestsPage()),
          ),
          GoRoute(
            path: VillagePage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: VillagePage()),
          ),
          GoRoute(
            path: ProfilePage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),
    ],
    // redirect to the login page if the user is not logged in
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn = state.matchedLocation == LoginPage.route;
      if (!loggedIn) return LoginPage.route;
      if (loggingIn) return HomePage.route;
      // no need to redirect at all
      return null;
    },
  );
}
