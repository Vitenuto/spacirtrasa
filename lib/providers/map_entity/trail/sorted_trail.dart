import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/sorted_trail.g.dart';

@Riverpod(keepAlive: true)
class SortedTrailProvider extends _$SortedTrailProvider {
  @override
  List<TrailWithDetails> build() {
    logger.t("Building SortedTrail provider...");
    final trailsWithLength = ref.watch(trailWithDetailsProvider);
    return trailsWithLength..sort();
  }
}
