import 'package:spacirtrasa/models/map_entity/trail/trail.dart';

class TrailWithDetails {
  final Trail trail;
  final double length;
  final double? distance;

  TrailWithDetails(this.trail, this.length, this.distance);
}