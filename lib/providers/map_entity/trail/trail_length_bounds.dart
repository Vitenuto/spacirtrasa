import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_with_details.dart';

part '../../generated/map_entity/trail/trail_length_bounds.g.dart';

@riverpod
class TrailLengthBoundsProvider extends _$TrailLengthBoundsProvider {
  static final _log = Logger();

  @override
  (double, double)? build() {
    _log.t("Building TrailLengthBounds provider...");
    final trailsWithLength = ref.watch(trailWithDetailsProvider);

    if (trailsWithLength.isEmpty) {
      return null;
    }
    return _calculateBounds(trailsWithLength);
  }

  (double, double) _calculateBounds(List<TrailWithDetails> trailsWithLength) {
    var min = trailsWithLength.first.length;
    var max = trailsWithLength.first.length;
    for (var trail in trailsWithLength) {
      if (trail.length < min) {
        min = trail.length;
      }
      if (trail.length > max) {
        max = trail.length;
      }
    }
    return (min, max);
  }
}
