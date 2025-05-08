import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/poi/poi_with_distance.g.dart';

@riverpod
class PoiWithDistanceProvider extends _$PoiWithDistanceProvider {
  static final log = Logger();

  @override
  List<PoiWithDistance> build() {
    log.t("Building PoiWithDistance provider...");
    final pois = ref.watch(poiProvider);
    final currentPosition = ref.watch(positionProvider)?.toLatLng();

    return pois.map((poi) {
      if (currentPosition == null) {
        return PoiWithDistance(poi, null);
      }

      final distance = Geolocator.distanceBetween(
        poi.location.latitude,
        poi.location.longitude,
        currentPosition.latitude,
        currentPosition.longitude,
      );
      return PoiWithDistance(poi, distance);
    }).toList();
  }
}
