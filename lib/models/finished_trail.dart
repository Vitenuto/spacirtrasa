import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converters.dart';

part 'generated/finished_trail.freezed.dart';
part 'generated/finished_trail.g.dart';

@freezed
abstract class FinishedTrail with _$FinishedTrail {
  const factory FinishedTrail({
    @JsonKey(name: 'trail_id') required String trailId,
    @JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp finishedAt,
  }) = _FinishedTrail;

  factory FinishedTrail.fromJson(Map<String, dynamic> json) => _$FinishedTrailFromJson(json);
}
