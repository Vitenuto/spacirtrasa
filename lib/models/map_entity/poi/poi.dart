import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/poi/poi.freezed.dart';
part '../../generated/map_entity/poi/poi.g.dart';

@freezed
abstract class Poi extends MapEntity with _$Poi {
  Poi._();

  factory Poi({
    required String id,
    required Map<String, String> title,
    required Map<String, String> markdownData,
    required String imgUrl,
    @GeoPointConverter() required GeoPoint location,
    required PoiFlag flag,
    @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp createdAt,
  }) = _Poi;

  @override
  Icon get icon => const Icon(Icons.pin_drop_outlined);

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
}
