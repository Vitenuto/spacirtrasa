import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/pages/home/main.dart';
import 'package:spacirtrasa/pages/login.dart';
import 'package:spacirtrasa/pages/pois/main.dart';
import 'package:spacirtrasa/pages/profile/main.dart';
import 'package:spacirtrasa/pages/trails/main.dart';
import 'package:spacirtrasa/pages/village.dart';
import 'package:spacirtrasa/widgets/main_frame.dart';

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
        path: LoginPage.route,
        builder: (context, state) => LoginPage(),
      ),

      ShellRoute(
        navigatorKey: _shellNavKey,
        pageBuilder: (context, state, child) {
          log.d("Shell route: ${state.matchedLocation}");
          return NoTransitionPage(
            child: MainFrame(location: state.matchedLocation, child: child),
          );
        },
        routes: [
          GoRoute(
            path: HomePage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: TrailsPage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: TrailsPage()),
          ),
          GoRoute(
            path: PoisPage.route,
            parentNavigatorKey: _shellNavKey,
            pageBuilder: (context, state) => NoTransitionPage(child: PoisPage()),
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

    redirect: (BuildContext context, GoRouterState state) async {
      if (FirebaseAuth.instance.currentUser == null) return LoginPage.route;
      // User is logged in, but trying to access the login page -> redirect to home
      if (state.matchedLocation == LoginPage.route) return HomePage.route;
      // no need to redirect at all
      return null;
    },
  );
}
