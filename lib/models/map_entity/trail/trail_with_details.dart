import 'package:spacirtrasa/models/map_entity/trail/trail.dart';

class TrailWithDetails implements Comparable<TrailWithDetails> {
  final Trail trail;
  final double length;
  final double? distance;

  TrailWithDetails(this.trail, this.length, this.distance);

  @override
  int compareTo(TrailWithDetails other) {
    return distance?.compareTo(other.distance ?? 0) ?? 0;
  }
}
