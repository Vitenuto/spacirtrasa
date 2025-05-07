import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/trail_with_length.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_with_length.dart';

part '../../generated/map_entity/trail/sorted_trail.g.dart';

@riverpod
class SortedTrailProvider extends _$SortedTrailProvider {
  static final log = Logger();

  @override
  List<TrailWithLength> build() {
    log.t("Building SortedTrail provider...");
    final trailsWithLength = ref.watch(trailWithLengthProvider);
    return trailsWithLength..sort((a, b) => a.length.compareTo(b.length));
  }
}
