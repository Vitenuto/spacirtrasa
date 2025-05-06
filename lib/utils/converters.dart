import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

class FirestoreConverters {
  static final log = Logger();

  static T Function(DocumentSnapshot<Map<String, dynamic>>, SnapshotOptions?) fromFirestore<T>(
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return (snapshot, _) {
      try {
        return fromJson({'id': snapshot.id, ...(snapshot.data() ?? {})});
      } catch (e) {
        log.e(
          "Unable to parse '$T' from firestore object having id: ${snapshot.id} and data: ${snapshot.data()}",
        );
        rethrow;
      }
    };
  }

  static Map<String, Object?> Function(dynamic, SetOptions?) toFirestore() {
    return (value, _) {
      final json = value.toJson();
      json.remove('id');

      return json;
    };
  }
}

class GeoPointConverter implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(json['lat']!, json['lng']!);
  }

  @override
  Map<String, double> toJson(GeoPoint point) {
    return {'lat': point.latitude, 'lng': point.longitude};
  }
}

Timestamp dateFromJson(int timestamp) => Timestamp.fromMillisecondsSinceEpoch(timestamp);

int dateToJson(Timestamp timestamp) => timestamp.millisecondsSinceEpoch;

extension PositionConversion on Position {
   LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}