import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/poi/poi_with_distance.g.dart';

@Riverpod(keepAlive: true)
class PoiWithDistanceProvider extends _$PoiWithDistanceProvider {
  late LatLng? _currentPosition;

  @override
  List<PoiWithDistance> build() {
    logger.t("Building PoiWithDistance provider...");
    final pois = ref.watch(poiProvider);
    _currentPosition = ref.watch(positionProvider)?.toLatLng();
    return pois.map(_toPoiWithDistance).toList();
  }

  PoiWithDistance _toPoiWithDistance(Poi poi) {
    if (_currentPosition == null) {
      return PoiWithDistance(poi, null);
    }

    final distance = Geolocator.distanceBetween(
      poi.location.latitude,
      poi.location.longitude,
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    return PoiWithDistance(poi, distance);
  }
}
