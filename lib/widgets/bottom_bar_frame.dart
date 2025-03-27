import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacirtrasa/pages/interests.dart';
import 'package:spacirtrasa/pages/paths.dart';
import 'package:spacirtrasa/pages/village.dart';

import '../pages/home.dart';
import '../pages/profile.dart';

class BottomBarFrame extends StatefulWidget {
  String location;

  BottomBarFrame({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<BottomBarFrame> createState() => _BottomBarFrameState();
}

class _BottomBarFrameState extends State<BottomBarFrame> {
  int _currentIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'HOME',
      initialLocation: HomePage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'PATHS',
      initialLocation: PathsPage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.interests_outlined),
      activeIcon: Icon(Icons.interests),
      label: 'INTERESTS',
      initialLocation: InterestsPage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.villa_outlined),
      activeIcon: Icon(Icons.villa),
      label: 'VILLAGE',
      initialLocation: VillagePage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.account_circle_outlined),
      activeIcon: Icon(Icons.account_circle),
      label: 'MY',
      initialLocation: ProfilePage.route,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex:
            widget.location == HomePage.route
                ? 0
                : widget.location == PathsPage.route
                ? 1
                : widget.location == InterestsPage.route
                ? 2
                : widget.location == VillagePage.route
                ? 3
                : 4,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    router.go(location);
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem({
    required this.initialLocation,
    required super.icon,
    super.label,
    Widget? activeIcon,
  }) : super(activeIcon: activeIcon ?? icon);
}
