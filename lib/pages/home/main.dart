import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/home/map.dart';
import 'package:spacirtrasa/pages/home/snap_list.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';

class HomePage extends ConsumerWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const MainMap(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ExpandableSheet((isExpanded) => SnapList(isExpanded)),
        ),
      ],
    );
  }
}
