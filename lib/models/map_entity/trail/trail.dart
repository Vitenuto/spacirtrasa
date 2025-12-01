import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_flag.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/trail/trail.freezed.dart';
part '../../generated/map_entity/trail/trail.g.dart';

@freezed
abstract class Trail extends MapEntity with _$Trail {
  Trail._();

  factory Trail({
    required String id,
    required Map<String, String> title,
    required Map<String, String> markdownData,
    @GeoPointConverter() required List<GeoPoint> path,
    required TrailFlag flag,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Trail;

  factory Trail.fromJson(Map<String, dynamic> json) => _$TrailFromJson(json);

  @override
  String? get imgUrl => null;

  @override
  Icon get icon => const Icon(Icons.route);

  MaterialColor get flagColor {
    switch (flag) {
      case TrailFlag.stroller:
        return Colors.green;
      case TrailFlag.tourist:
        return Colors.orange;
      case TrailFlag.hill:
        return Colors.red;
    }
  }

  double? getDistanceFromLocation(Position? location) {
    if (location == null || path.isEmpty) {
      return null;
    }

    var minDistance = double.infinity;
    for (int i = 0; i < path.length - 1; i++) {
      final pointA = path[i];
      final pointB = path[i + 1];

      final distToSegment = _distanceToSegment(location, pointA, pointB);
      if (distToSegment < minDistance) {
        minDistance = distToSegment;
      }
    }
    return minDistance;
  }

  /// Computes the perpendicular distance from a point to a segment
  double _distanceToSegment(Position p, GeoPoint a, GeoPoint b) {
    final pLatLng = LatLng(p.latitude, p.longitude);
    final aLatLng = LatLng(a.latitude, a.longitude);
    final bLatLng = LatLng(b.latitude, b.longitude);

    final d = Distance();

    final double lengthAB = d.distance(aLatLng, bLatLng);
    if (lengthAB == 0.0) return d.distance(pLatLng, aLatLng);

    // Project point p onto line segment ab
    final double t =
        ((p.latitude - a.latitude) * (b.latitude - a.latitude) +
            (p.longitude - a.longitude) * (b.longitude - a.longitude)) /
        ((b.latitude - a.latitude) * (b.latitude - a.latitude) +
            (b.longitude - a.longitude) * (b.longitude - a.longitude));

    if (t < 0) return d.distance(pLatLng, aLatLng);
    if (t > 1) return d.distance(pLatLng, bLatLng);

    // Projection falls on the segment
    final projection = LatLng(
      a.latitude + t * (b.latitude - a.latitude),
      a.longitude + t * (b.longitude - a.longitude),
    );

    return d.distance(pLatLng, projection);
  }
}
