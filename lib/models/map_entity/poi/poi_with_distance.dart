import 'package:spacirtrasa/models/map_entity/poi/poi.dart';

class PoiWithDistance implements Comparable<PoiWithDistance> {
  final Poi poi;
  final double? distance;

  PoiWithDistance(this.poi, this.distance);

  @override
  int compareTo(PoiWithDistance other) {
    return distance?.compareTo(other.distance ?? 0) ?? 0;
  }
}
