// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/trail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trail _$TrailFromJson(Map<String, dynamic> json) => _Trail(
  id: json['id'] as String,
  title: Map<String, String>.from(json['title'] as Map),
  markdownData: Map<String, String>.from(json['markdownData'] as Map),
  path:
      (json['path'] as List<dynamic>)
          .map(
            (e) =>
                const GeoPointConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  flag: $enumDecode(_$TrailFlagEnumMap, json['flag']),
  createdAt: dateFromJson((json['created_at'] as num).toInt()),
);

Map<String, dynamic> _$TrailToJson(_Trail instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'markdownData': instance.markdownData,
  'path': instance.path.map(const GeoPointConverter().toJson).toList(),
  'flag': _$TrailFlagEnumMap[instance.flag]!,
  'created_at': dateToJson(instance.createdAt),
};

const _$TrailFlagEnumMap = {
  TrailFlag.stroller: 'stroller',
  TrailFlag.tourist: 'tourist',
  TrailFlag.hill: 'hill',
};
