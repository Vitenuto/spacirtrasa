import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/utils/converters.dart';

part '../../generated/map_entity/trail/finished_trail.freezed.dart';
part '../../generated/map_entity/trail/finished_trail.g.dart';

@freezed
abstract class FinishedTrail with _$FinishedTrail {
  FinishedTrail._();

  factory FinishedTrail({
    @JsonKey(name: 'trail_id') required String trailId,
    @JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson)
    required Timestamp finishedAt,
  }) = _FinishedTrail;

  String get finishedAtFormatted => DateFormat.yMMMd().add_Hm().format(finishedAt.toDate());

  factory FinishedTrail.fromJson(Map<String, dynamic> json) => _$FinishedTrailFromJson(json);
}
