import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/trail_with_details.g.dart';

@Riverpod(keepAlive: true)
class TrailWithDetailsProvider extends _$TrailWithDetailsProvider {
  late Position? _currentPosition;

  @override
  List<TrailWithDetails> build() {
    logger.t("Building TrailWithDetails provider...");
    final trails = ref.watch(trailProvider);
    _currentPosition = ref.watch(positionProvider);
    return trails.map(_toTrailWithDetails).toList();
  }

  TrailWithDetails _toTrailWithDetails(Trail trail) => TrailWithDetails(
    trail,
    trail.path.toLength(),
    trail.getDistanceFromLocation(_currentPosition),
  );
}
