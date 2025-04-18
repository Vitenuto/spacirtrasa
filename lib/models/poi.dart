import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converters.dart';
import 'map_entity.dart';

part 'generated/poi.freezed.dart';
part 'generated/poi.g.dart';

enum PoiFlags { monument, nature, food, transportation }

@freezed
abstract class Poi with _$Poi implements MapEntity {
  const factory Poi({
    required String id,
    required String title,
    required String imgUrl,
    required String markdownData,
    @GeoPointConverter() required GeoPoint location,
    required Set<PoiFlags> flags,
    @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)
    required Timestamp createdAt,
  }) = _Poi;

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
}

Timestamp _dateFromJson(int timestamp) => Timestamp.fromMillisecondsSinceEpoch(timestamp);

int _dateToJson(Timestamp timestamp) => timestamp.millisecondsSinceEpoch;
