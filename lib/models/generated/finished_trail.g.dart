// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../finished_trail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinishedTrail _$FinishedTrailFromJson(Map<String, dynamic> json) =>
    _FinishedTrail(
      trailId: json['trailId'] as String,
      finishedAt: dateFromJson((json['finished_at'] as num).toInt()),
    );

Map<String, dynamic> _$FinishedTrailToJson(_FinishedTrail instance) =>
    <String, dynamic>{
      'trailId': instance.trailId,
      'finished_at': dateToJson(instance.finishedAt),
    };
