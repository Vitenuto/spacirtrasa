import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/pois/filter_view.dart';
import 'package:spacirtrasa/pages/pois/poi_tile.dart';
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
      child: Column(
        children: [
          FilterView(),
          Expanded(
            child: ListView.builder(
              itemCount: poisWithDistance.length,
              itemBuilder: (context, index) {
                final poiWithDistance = poisWithDistance[index];
                return PoiTile(poiWithDistance);
              },
            ),
          ),
        ],
      ),
    );
  }
}
