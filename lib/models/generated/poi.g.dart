// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Poi _$PoiFromJson(Map<String, dynamic> json) => _Poi(
  id: json['id'] as String,
  title: json['title'] as String,
  imgUrl: json['imgUrl'] as String,
  markdownData: json['markdownData'] as String,
  location: const GeoPointConverter().fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  flags:
      (json['flags'] as List<dynamic>)
          .map((e) => $enumDecode(_$PoiFlagsEnumMap, e))
          .toSet(),
  createdAt: dateFromJson((json['created_at'] as num).toInt()),
);

Map<String, dynamic> _$PoiToJson(_Poi instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'imgUrl': instance.imgUrl,
  'markdownData': instance.markdownData,
  'location': const GeoPointConverter().toJson(instance.location),
  'flags': instance.flags.map((e) => _$PoiFlagsEnumMap[e]!).toList(),
  'created_at': dateToJson(instance.createdAt),
};

const _$PoiFlagsEnumMap = {
  PoiFlags.monument: 'monument',
  PoiFlags.nature: 'nature',
  PoiFlags.food: 'food',
  PoiFlags.transportation: 'transportation',
};
