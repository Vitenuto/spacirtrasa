import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/home/map.dart';
import 'package:spacirtrasa/pages/paths/snap_list.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';

class HomePage extends ConsumerWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onExpansionCallback(isExpanded) {
      if (isExpanded) {
        ref.read(selectedPoiProvider.notifier).setSelected(null);
      }
    }

    return Stack(
      children: [
        const MainMap(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ExpandableSheet(
            (isExpanded) => SnapList(isExpanded),
            onExpansionCallback: onExpansionCallback,
          ),
        ),
      ],
    );
  }
}
