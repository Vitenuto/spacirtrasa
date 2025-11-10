import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacirtrasa/pages/home/main.dart';
import 'package:spacirtrasa/pages/pois/main.dart';
import 'package:spacirtrasa/pages/profile/main.dart';
import 'package:spacirtrasa/pages/trails/main.dart';
import 'package:spacirtrasa/pages/village.dart';
import 'package:spacirtrasa/widgets/main_frame.dart';

final _rootNavKey = GlobalKey<NavigatorState>();
final _shellNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: HomePage.route,
  navigatorKey: _rootNavKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: MainFrame(location: state.matchedLocation, child: child));
      },
      routes: [
        GoRoute(
          path: HomePage.route,
          pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: TrailsPage.route,
          pageBuilder: (context, state) => NoTransitionPage(child: TrailsPage()),
        ),
        GoRoute(
          path: PoisPage.route,
          pageBuilder: (context, state) => NoTransitionPage(child: PoisPage()),
        ),
        GoRoute(
          path: VillagePage.route,
          pageBuilder: (context, state) => NoTransitionPage(child: VillagePage()),
        ),
        GoRoute(
          path: ProfilePage.route,
          pageBuilder: (context, state) => NoTransitionPage(child: ProfilePage()),
        ),
      ],
    ),
  ],
);
