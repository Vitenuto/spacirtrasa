// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Note _$NoteFromJson(Map<String, dynamic> json) => _Note(
  mapEntityId: json['map_entity_id'] as String,
  text: json['text'] as String,
  type: $enumDecode(_$MapEntityTypeEnumMap, json['type']),
);

Map<String, dynamic> _$NoteToJson(_Note instance) => <String, dynamic>{
  'map_entity_id': instance.mapEntityId,
  'text': instance.text,
  'type': _$MapEntityTypeEnumMap[instance.type]!,
};

const _$MapEntityTypeEnumMap = {
  MapEntityType.poi: 'poi',
  MapEntityType.trail: 'trail',
};
