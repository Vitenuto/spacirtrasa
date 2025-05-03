import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converters.dart';
import 'map_entity.dart';

part 'generated/poi.freezed.dart';
part 'generated/poi.g.dart';

enum PoiFlags { monument, nature, food, transportation }

@freezed
abstract class Poi extends MapEntity with _$Poi {
  Poi._();

  factory Poi({
    required String id,
    required String title,
    required String imgUrl,
    required String markdownData,
    @GeoPointConverter() required GeoPoint location,
    required Set<PoiFlags> flags,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Poi;

  static Icon getIcon() => const Icon(Icons.pin_drop_outlined);

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
  @override
  Icon get icon => getIcon();
}
