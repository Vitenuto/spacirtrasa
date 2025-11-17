import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/providers/map_entity/poi/sorted_poi.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/poi/filtered_poi.g.dart';

@Riverpod(keepAlive: true)
class FilteredPoiProvider extends _$FilteredPoiProvider {
  late PoiFilter _poiFilter;

  @override
  List<PoiWithDistance> build() {
    final pois = ref.watch(sortedPoiProvider);
    _poiFilter = ref.watch(poiFilterProvider);
    logger.t("Building FilteredPoi provider with ${pois.length} POIs and filter: $_poiFilter");
    return pois.where(_matchesFilter).toList();
  }

  bool _matchesFilter(PoiWithDistance poiWithDistance) {
    if (_poiFilter.searchText.isNotEmpty) {
      final searchText = _poiFilter.searchText.toLowerCase();
      if (!poiWithDistance.poi.title.toLowerCase().contains(searchText)) {
        logger.t("POI ${poiWithDistance.poi.title} does not match search text: $searchText");
        return false;
      }
    }

    final requiredFlag = _poiFilter.flag;
    if (requiredFlag != null && requiredFlag != poiWithDistance.poi.flag) {
      return false;
    }
    return true;
  }
}
