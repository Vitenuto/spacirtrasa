import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/sorted_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_filter.dart';

part '../../generated/map_entity/trail/filtered_trail.g.dart';

@riverpod
class FilteredTrailProvider extends _$FilteredTrailProvider {
  static final log = Logger();

  @override
  List<TrailWithDetails> build() {
    log.t("Building FilteredTrail provider...");
    final trails = ref.watch(sortedTrailProvider);
    final filter = ref.watch(trailFilterProvider);

    return trails.where((trailWithDetail) {
      if (filter.searchText.isNotEmpty) {
        final searchText = filter.searchText.toLowerCase();
        if (!trailWithDetail.trail.title.toLowerCase().contains(searchText)) {
          return false;
        }
      }

      if (trailWithDetail.length < filter.bounds.$1 || trailWithDetail.length > filter.bounds.$2) {
        return false;
      }

      final requiredFlag = filter.flag;
      if (requiredFlag != null && requiredFlag != trailWithDetail.trail.flag) {
        return false;
      }

      return true;
    }).toList();
  }
}
