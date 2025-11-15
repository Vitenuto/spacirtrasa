import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_filter.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/sorted_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_filter.dart';

part '../../generated/map_entity/trail/filtered_trail.g.dart';

@Riverpod(keepAlive: true)
class FilteredTrailProvider extends _$FilteredTrailProvider {
  static final _log = Logger();
  late TrailFilter _trailFilter;

  @override
  List<TrailWithDetails> build() {
    _log.t("Building FilteredTrail provider...");
    final trails = ref.watch(sortedTrailProvider);
    _trailFilter = ref.watch(trailFilterProvider);
    return trails.where(_matchesFilter).toList();
  }

  bool _matchesFilter(TrailWithDetails trailWithDetails) {
    if (_trailFilter.searchText.isNotEmpty) {
      final searchText = _trailFilter.searchText.toLowerCase();
      if (!trailWithDetails.trail.title.toLowerCase().contains(searchText)) {
        return false;
      }
    }

    if (trailWithDetails.length < _trailFilter.bounds.$1 ||
        trailWithDetails.length > _trailFilter.bounds.$2) {
      return false;
    }

    final requiredFlag = _trailFilter.flag;
    if (requiredFlag != null && requiredFlag != trailWithDetails.trail.flag) {
      return false;
    }

    return true;
  }
}
