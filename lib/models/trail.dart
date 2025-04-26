import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converters.dart';
import 'map_entity.dart';

part 'generated/trail.freezed.dart';
part 'generated/trail.g.dart';

enum TrailFlags { stroller, tourist, hill }

@freezed
abstract class Trail with _$Trail implements MapEntity {
  const Trail._();

  const factory Trail({
    required String id,
    required String title,
    required String markdownData,
    @GeoPointConverter() required List<GeoPoint> path,
    required Set<TrailFlags> flags,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Trail;

  factory Trail.fromJson(Map<String, dynamic> json) => _$TrailFromJson(json);
}
