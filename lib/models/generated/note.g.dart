// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Note _$NoteFromJson(Map<String, dynamic> json) => _Note(
  id: json['id'] as String,
  text: json['text'] as String,
  ownerId: json['owner_id'] as String,
);

Map<String, dynamic> _$NoteToJson(_Note instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'owner_id': instance.ownerId,
};
