import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/map_entity.dart';
import 'package:spacirtrasa/models/trail_flags.dart';
import 'package:spacirtrasa/utils/converters.dart';

part 'generated/trail.freezed.dart';
part 'generated/trail.g.dart';

@freezed
abstract class Trail extends MapEntity with _$Trail {
  Trail._();

  factory Trail({
    required String id,
    required String title,
    required String markdownData,
    @GeoPointConverter() required List<GeoPoint> path,
    required Set<TrailFlags> flags,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Trail;

  static Icon getIcon() => const Icon(Icons.route);

  factory Trail.fromJson(Map<String, dynamic> json) => _$TrailFromJson(json);
  @override
  String? get imgUrl => null;
  @override
  Icon get icon => getIcon();
}
