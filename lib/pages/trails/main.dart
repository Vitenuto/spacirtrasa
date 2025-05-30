import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/trails/animated_trail_filter.dart';
import 'package:spacirtrasa/pages/trails/map.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/filtered_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';
import 'package:spacirtrasa/widgets/map_entity_list/expandable_list.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';
import 'package:spacirtrasa/widgets/map_entity_list/trail_list_item.dart';

class TrailsPage extends ConsumerWidget {
  static const route = "/trails";

  const TrailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTrail = ref.watch(selectedTrailProvider);
    final pinnedTrail = ref.watch(pinnedTrailProvider);
    final items = ref.watch(filteredTrailProvider);
    final listItems = List<ListItem>.empty(growable: true);
    for (final item in items) {
      final trail = item.trail;
      final TrailListItem listItem = TrailListItem(
        trail: item.trail,
        isSelected: selectedTrail != null && selectedTrail.id == trail.id,
        isPinned: pinnedTrail != null && pinnedTrail.id == trail.id,
        onSelected: () => ref.read(selectedTrailProvider.notifier).setSelected(item.trail),
        onShowDetail: () => showTrailDetail(context, item.trail),
        onLongPress: () => ref.read(pinnedTrailProvider.notifier).setPinned(trail),
      );

      listItems.add(listItem);
    }

    return Stack(
      children: [
        const MainMap(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ExpandableSheet(
            (isExpanded) => ExpandableList(
              isExpanded,
              'trails.hold-to-pin'.tr(),
              listItems,
              filterBuilder: (isExpanded) => AnimatedTrailFilter(isExpanded),
            ),
          ),
        ),
      ],
    );
  }
}
