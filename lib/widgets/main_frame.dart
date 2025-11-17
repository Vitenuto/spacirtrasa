import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacirtrasa/pages/home/main.dart';
import 'package:spacirtrasa/pages/pois/main.dart';
import 'package:spacirtrasa/pages/profile/main.dart';
import 'package:spacirtrasa/pages/trails/main.dart';
import 'package:spacirtrasa/pages/village.dart';

class MainFrame extends StatefulWidget {
  final String location;
  final Widget child;

  const MainFrame({super.key, required this.child, required this.location});

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  int _currentIndex = 0;

  static List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: "navbar.home".tr().toUpperCase(),
      initialLocation: HomePage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: "navbar.trails".tr().toUpperCase(),
      initialLocation: TrailsPage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.interests_outlined),
      activeIcon: Icon(Icons.interests),
      label: "navbar.pois".tr().toUpperCase(),
      initialLocation: PoisPage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.villa_outlined),
      activeIcon: Icon(Icons.villa),
      label: "navbar.village".tr().toUpperCase(),
      initialLocation: VillagePage.route,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.account_circle_outlined),
      activeIcon: Icon(Icons.account_circle),
      label: "navbar.my".tr().toUpperCase(),
      initialLocation: ProfilePage.route,
    ),
  ];

  @override
  void didUpdateWidget(covariant MainFrame oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.location != widget.location) {
      setState(() => _currentIndex = _calculateIndex());
    }
  }

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
        currentIndex: _calculateIndex(),
        items: tabs,
      ),
    );
  }

  int _calculateIndex() {
    return widget.location == HomePage.route
        ? 0
        : widget.location == TrailsPage.route
        ? 1
        : widget.location == PoisPage.route
        ? 2
        : widget.location == VillagePage.route
        ? 3
        : 4;
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
