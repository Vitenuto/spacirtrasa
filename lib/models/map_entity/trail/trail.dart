import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    required String title,
    required String markdownData,
    @GeoPointConverter() required List<GeoPoint> path,
    required TrailFlag flag,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Trail;

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

  @override
  String? get imgUrl => null;

  @override
  Icon get icon => const Icon(Icons.route);

  factory Trail.fromJson(Map<String, dynamic> json) => _$TrailFromJson(json);
}
