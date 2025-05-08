import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import 'constants.dart';

final log = Logger();

void showFullDialog(BuildContext context, final Widget child) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(child: child),
  );
}

double get fullItemHeight => itemListHeight + (itemListPadding * 2);

Marker buildUserLocationMarker(final Position currentLoc) {
  return Marker(
    point: LatLng(currentLoc.latitude, currentLoc.longitude),
    width: 20,
    height: 20,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(color: Colors.white, width: 3),
      ),
    ),
  );
}

bool isNearTrail(final Position location, final List<GeoPoint> trail) {
  for (int i = 0; i < trail.length - 1; i++) {
    final pointA = trail[i];
    final pointB = trail[i + 1];

    final distToSegment = _distanceToSegment(location, pointA, pointB);

    if (distToSegment < userFromTrailThresholdMeters) {
      return true;
    }
  }
  return false;
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