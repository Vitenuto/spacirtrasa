import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/poi/sorted_poi.g.dart';

@riverpod
class SortedPoiProvider extends _$SortedPoiProvider {
  static final log = Logger();

  @override
  List<PoiWithDistance> build() {
    log.t("Building SortedPoi provider...");
    final pois = ref.watch(poiProvider);
    final currentPosition = ref.watch(positionProvider)?.toLatLng() ?? defaultPosition;

    return pois.map((poi) {
        final distance = Geolocator.distanceBetween(
          poi.location.latitude,
          poi.location.longitude,
          currentPosition.latitude,
          currentPosition.longitude,
        );
        return PoiWithDistance(poi, distance);
      }).toList()
      ..sort((a, b) => a.distance.compareTo(b.distance));
  }
}
