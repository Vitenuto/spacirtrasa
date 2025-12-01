// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Poi _$PoiFromJson(Map<String, dynamic> json) => _Poi(
  id: json['id'] as String,
  title: Map<String, String>.from(json['title'] as Map),
  markdownData: Map<String, String>.from(json['markdownData'] as Map),
  imgUrl: json['imgUrl'] as String,
  location: const GeoPointConverter().fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  flag: $enumDecode(_$PoiFlagEnumMap, json['flag']),
  createdAt: dateFromJson((json['created_at'] as num).toInt()),
);

Map<String, dynamic> _$PoiToJson(_Poi instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'markdownData': instance.markdownData,
  'imgUrl': instance.imgUrl,
  'location': const GeoPointConverter().toJson(instance.location),
  'flag': _$PoiFlagEnumMap[instance.flag]!,
  'created_at': dateToJson(instance.createdAt),
};

const _$PoiFlagEnumMap = {
  PoiFlag.monument: 'monument',
  PoiFlag.nature: 'nature',
  PoiFlag.food: 'food',
  PoiFlag.transportation: 'transportation',
};
