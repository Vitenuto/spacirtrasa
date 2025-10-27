import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_with_details.dart';

part '../../generated/map_entity/trail/sorted_trail.g.dart';

@riverpod
class SortedTrailProvider extends _$SortedTrailProvider {
  static final _log = Logger();

  @override
  List<TrailWithDetails> build() {
    _log.t("Building SortedTrail provider...");
    final trailsWithLength = ref.watch(trailWithDetailsProvider);
    return trailsWithLength..sort();
  }
}
