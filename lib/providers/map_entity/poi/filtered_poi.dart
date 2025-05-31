import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/providers/map_entity/poi/sorted_poi.dart';

part '../../generated/map_entity/poi/filtered_poi.g.dart';

@riverpod
class FilteredPoiProvider extends _$FilteredPoiProvider {
  static final log = Logger();

  @override
  List<PoiWithDistance> build() {
    final pois = ref.watch(sortedPoiProvider);
    final filter = ref.watch(poiFilterProvider);
    log.t("Building FilteredPoi provider with ${pois.length} POIs and filter: $filter");

    return pois.where((poiWithDistance) {
      if (filter.searchText.isNotEmpty) {
        final searchText = filter.searchText.toLowerCase();
        if (!poiWithDistance.poi.title.toLowerCase().contains(searchText)) {
          log.t("POI ${poiWithDistance.poi.title} does not match search text: $searchText");
          return false;
        }
      }

      final requiredFlag = filter.flag;
      if (requiredFlag != null && requiredFlag != poiWithDistance.poi.flag) {
        return false;
      }
      return true;
    }).toList();
  }
}
