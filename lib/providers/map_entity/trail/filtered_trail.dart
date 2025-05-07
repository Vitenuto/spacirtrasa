import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/trail_with_length.dart';
import 'package:spacirtrasa/providers/map_entity/trail/sorted_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_filter.dart';

part '../../generated/map_entity/trail/filtered_trail.g.dart';

@riverpod
class FilteredTrailProvider extends _$FilteredTrailProvider {
  static final log = Logger();

  @override
  List<TrailWithLength> build() {
    log.t("Building FilteredTrail provider...");
    final trails = ref.watch(sortedTrailProvider);
    final filter = ref.watch(trailFilterProvider);

    return trails.where((trailWithLength) {
      if (filter.searchText.isNotEmpty) {
        final searchText = filter.searchText.toLowerCase();
        if (!trailWithLength.trail.title.toLowerCase().contains(searchText)) {
          return false;
        }
      }

      if (trailWithLength.length < filter.bounds.$1 ||
          trailWithLength.length > filter.bounds.$2) {
        return false;
      }

      final requiredFlags = filter.flags;
      if (requiredFlags.isNotEmpty) {
        final trailFlags = trailWithLength.trail.flags;
        if (!requiredFlags.every((requiredFlag) => trailFlags.contains(requiredFlag))) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
