import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/home/animated_poi_tile.dart';
import 'package:spacirtrasa/pages/pois/filter_view.dart';
import 'package:spacirtrasa/providers/map_entity/poi/filtered_poi.dart';

class PoiListView extends ConsumerStatefulWidget {
  const PoiListView({super.key});

  @override
  ConsumerState<PoiListView> createState() => _PoiListViewState();
}

class _PoiListViewState extends ConsumerState<PoiListView> {
  @override
  Widget build(BuildContext context) {
    final poisWithDistance = ref.watch(filteredPoiProvider);

    return Padding(
      padding: const EdgeInsets.all(8).copyWith(top: 4.0),
      child: ListView.builder(
        itemCount: poisWithDistance.length + 1, // +1 for the filter view
        itemBuilder: (context, index) {
          if (index == 0) return FilterView();

          final poiWithDistance = poisWithDistance[index - 1];
          return AnimatedPoiTile(poiWithDistance: poiWithDistance, isExpanded: true);
        },
      ),
    );
  }
}
