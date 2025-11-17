import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/trail_length_bounds.g.dart';

@Riverpod(keepAlive: true)
class TrailLengthBoundsProvider extends _$TrailLengthBoundsProvider {
  @override
  (double, double)? build() {
    logger.t("Building TrailLengthBounds provider...");
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
