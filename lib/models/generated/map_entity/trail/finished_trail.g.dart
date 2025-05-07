// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/finished_trail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinishedTrail _$FinishedTrailFromJson(Map<String, dynamic> json) =>
    _FinishedTrail(
      trailId: json['trail_id'] as String,
      finishedAt: dateFromJson((json['finished_at'] as num).toInt()),
    );

Map<String, dynamic> _$FinishedTrailToJson(_FinishedTrail instance) =>
    <String, dynamic>{
      'trail_id': instance.trailId,
      'finished_at': dateToJson(instance.finishedAt),
    };
