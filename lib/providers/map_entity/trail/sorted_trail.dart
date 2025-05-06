import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/trail/sorted_trail.g.dart';

@riverpod
class SortedTrailProvider extends _$SortedTrailProvider {
  static final log = Logger();

  @override
  List<TrailWithLength> build() {
    log.t("Building SortedTrail provider...");
    final trails = ref.watch(trailProvider);

    return trails.map((trail) {
      var trailWithLength = TrailWithLength(trail, trail.path.toLength());
      log.i("Trail: ${trail.title}, length: ${trailWithLength.length}");
      return trailWithLength;
    }).toList()
      ..sort((a, b) => a.length.compareTo(b.length));
  }
}

class TrailWithLength {
  final Trail trail;
  final double length;

  TrailWithLength(this.trail, this.length);

  @override
  String toString() {
    return 'TrailWithLength{trail: $trail, distance: $length}';
  }
}
