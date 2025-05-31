import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/pois/animated_poi_filter.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/providers/map_entity/poi/filtered_poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/widgets/expandable_sheet.dart';
import 'package:spacirtrasa/widgets/map.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';
import 'package:spacirtrasa/widgets/map_entity_list/poi_list_item.dart';

class PoisPage extends ConsumerWidget {
  static const route = "/pois";

  const PoisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
    children: [
      const MainMap(),
      Align(
        alignment: Alignment.bottomCenter,
        child: ExpandableSheet(
          listTitle: 'home.interests-around'.tr(),
          items: getListItems(ref, context),
          filterBuilder: (isExpanded) => AnimatedPoiFilter(isExpanded),
        ),
      ),
    ],
  );

  List<ListItem> getListItems(WidgetRef ref, BuildContext context) {
    final selectedPoi = ref.watch(selectedPoiProvider);
    final items = ref.watch(filteredPoiProvider);
    final listItems = List<ListItem>.empty(growable: true);
    for (final item in items) {
      final poi = item.poi;
      final listItem = PoiListItem(
        poiWithDistance: item,
        isSelected: selectedPoi != null && selectedPoi.id == poi.id,
        isPinned: false,
        onSelected: () => ref.read(selectedPoiProvider.notifier).setSelected(item.poi),
        onShowDetail: () => showPoiDetail(context, item.poi),
        onLongPress: null,
      );

      listItems.add(listItem);
    }
    return listItems;
  }
}
