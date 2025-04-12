import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converters.dart';

part 'generated/poi.freezed.dart';
part 'generated/poi.g.dart';

enum PoiFlags { monument, nature, food, transportation }

@freezed
abstract class Poi with _$Poi {
  const factory Poi({
    required String id,
    required String title,
    required String imgUrl,
    required String markdownData,
    @GeoPointConverter() required GeoPoint location,
    required Set<PoiFlags> flags,
    @JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson)
    required Timestamp creationDate,
  }) = _Poi;

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);
}

Timestamp _dateFromJson(int timestamp) => Timestamp.fromMillisecondsSinceEpoch(timestamp);

int _dateToJson(Timestamp timestamp) => timestamp.millisecondsSinceEpoch;
