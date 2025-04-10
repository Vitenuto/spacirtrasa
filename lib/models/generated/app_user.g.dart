// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  isAdmin: json['is_admin'] as bool? ?? false,
  favoriteIds:
      (json['favorite_ids'] as List<dynamic>).map((e) => e as String).toList(),
  notes:
      (json['notes'] as List<dynamic>)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'is_admin': instance.isAdmin,
  'favorite_ids': instance.favoriteIds,
  'notes': instance.notes.map((e) => e.toJson()).toList(),
};
