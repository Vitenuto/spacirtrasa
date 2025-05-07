import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/trail_with_length.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/trail/trail_with_length.g.dart';

@riverpod
class TrailWithLengthProvider extends _$TrailWithLengthProvider {
  static final log = Logger();

  @override
  List<TrailWithLength> build() {
    log.t("Building TrailWithLength provider...");
    final trails = ref.watch(trailProvider);
    return trails.map((trail) => TrailWithLength(trail, trail.path.toLength())).toList();
  }
}
