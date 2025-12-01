import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/pages/trails/animated_trail_filter.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/filtered_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';
import 'package:spacirtrasa/widgets/map.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';
import 'package:spacirtrasa/widgets/map_entity_list/trail_list_item.dart';

class TrailsPage extends ConsumerWidget {
  static const route = "/trails";

  const TrailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
    children: [
      const MainMap(showSelectedTrail: true),
      Align(
        alignment: Alignment.bottomCenter,
        child: ExpandableSheet(
          listTitle: 'trails.hold-to-pin'.tr(),
          items: getListItems(ref, context),
          filterBuilder: (isExpanded) => AnimatedTrailFilter(isExpanded),
        ),
      ),
    ],
  );

  List<ListItem> getListItems(WidgetRef ref, BuildContext context) {
    final selectedTrail = ref.watch(selectedTrailProvider);
    final pinnedTrail = ref.watch(pinnedTrailProvider);
    final items = ref.watch(filteredTrailProvider);
    final listItems = List<ListItem>.empty(growable: true);
    for (final item in items) {
      final trail = item.trail;
      final TrailListItem listItem = TrailListItem(
        trailWithDistance: item,
        isSelected: selectedTrail != null && selectedTrail.id == trail.id,
        isPinned: pinnedTrail != null && pinnedTrail.id == trail.id,
        onSelected: () => ref.read(selectedTrailProvider.notifier).setSelected(item.trail),
        onShowDetail: () => showTrailDetail(context, item.trail),
        onLongPress: () => setPinnedTrail(ref, trail),
      );

      listItems.add(listItem);
    }
    return listItems;
  }

  void setPinnedTrail(WidgetRef ref, Trail trail) {
    final isPinned = ref.read(pinnedTrailProvider.notifier).togglePinned(trail);
    if (isPinned) {
      Fluttertoast.showToast(msg: 'trails.pinned'.tr(args: [trail.titleLocalized]));
    } else {
      Fluttertoast.showToast(msg: 'trails.unpinned'.tr(args: [trail.titleLocalized]));
    }
  }
}
