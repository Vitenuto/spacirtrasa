// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../trail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trail _$TrailFromJson(Map<String, dynamic> json) => _Trail(
  id: json['id'] as String,
  title: json['title'] as String,
  markdownData: json['markdownData'] as String,
  path:
      (json['path'] as List<dynamic>)
          .map(
            (e) =>
                const GeoPointConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  flags:
      (json['flags'] as List<dynamic>)
          .map((e) => $enumDecode(_$TrailFlagsEnumMap, e))
          .toSet(),
  createdAt: _dateFromJson((json['created_at'] as num).toInt()),
);

Map<String, dynamic> _$TrailToJson(_Trail instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'markdownData': instance.markdownData,
  'path': instance.path.map(const GeoPointConverter().toJson).toList(),
  'flags': instance.flags.map((e) => _$TrailFlagsEnumMap[e]!).toList(),
  'created_at': _dateToJson(instance.createdAt),
};

const _$TrailFlagsEnumMap = {
  TrailFlags.stroller: 'stroller',
  TrailFlags.tourist: 'tourist',
  TrailFlags.hill: 'hill',
};
