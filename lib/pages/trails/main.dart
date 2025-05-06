import 'package:flutter/material.dart';
import 'package:spacirtrasa/pages/trails/map.dart';
import 'package:spacirtrasa/pages/trails/snap_list.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';

class TrailsPage extends StatelessWidget {
  static const route = "/trails";

  const TrailsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
