// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String get id;@JsonKey(name: 'is_admin') bool get isAdmin;@JsonKey(name: 'favorite_poi_ids') List<String> get favoritePoiIds;@JsonKey(name: 'favorite_trail_ids') List<String> get favoriteTrailIds;@JsonKey(name: 'finished_trails') List<FinishedTrail> get finishedTrails; List<Note> get notes;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&const DeepCollectionEquality().equals(other.favoritePoiIds, favoritePoiIds)&&const DeepCollectionEquality().equals(other.favoriteTrailIds, favoriteTrailIds)&&const DeepCollectionEquality().equals(other.finishedTrails, finishedTrails)&&const DeepCollectionEquality().equals(other.notes, notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isAdmin,const DeepCollectionEquality().hash(favoritePoiIds),const DeepCollectionEquality().hash(favoriteTrailIds),const DeepCollectionEquality().hash(finishedTrails),const DeepCollectionEquality().hash(notes));

@override
String toString() {
  return 'AppUser(id: $id, isAdmin: $isAdmin, favoritePoiIds: $favoritePoiIds, favoriteTrailIds: $favoriteTrailIds, finishedTrails: $finishedTrails, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'is_admin') bool isAdmin,@JsonKey(name: 'favorite_poi_ids') List<String> favoritePoiIds,@JsonKey(name: 'favorite_trail_ids') List<String> favoriteTrailIds,@JsonKey(name: 'finished_trails') List<FinishedTrail> finishedTrails, List<Note> notes
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? isAdmin = null,Object? favoritePoiIds = null,Object? favoriteTrailIds = null,Object? finishedTrails = null,Object? notes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,favoritePoiIds: null == favoritePoiIds ? _self.favoritePoiIds : favoritePoiIds // ignore: cast_nullable_to_non_nullable
as List<String>,favoriteTrailIds: null == favoriteTrailIds ? _self.favoriteTrailIds : favoriteTrailIds // ignore: cast_nullable_to_non_nullable
as List<String>,finishedTrails: null == finishedTrails ? _self.finishedTrails : finishedTrails // ignore: cast_nullable_to_non_nullable
as List<FinishedTrail>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<Note>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({required this.id, @JsonKey(name: 'is_admin') this.isAdmin = false, @JsonKey(name: 'favorite_poi_ids') required final  List<String> favoritePoiIds, @JsonKey(name: 'favorite_trail_ids') required final  List<String> favoriteTrailIds, @JsonKey(name: 'finished_trails') required final  List<FinishedTrail> finishedTrails, required final  List<Note> notes}): _favoritePoiIds = favoritePoiIds,_favoriteTrailIds = favoriteTrailIds,_finishedTrails = finishedTrails,_notes = notes;
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String id;
@override@JsonKey(name: 'is_admin') final  bool isAdmin;
 final  List<String> _favoritePoiIds;
@override@JsonKey(name: 'favorite_poi_ids') List<String> get favoritePoiIds {
  if (_favoritePoiIds is EqualUnmodifiableListView) return _favoritePoiIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoritePoiIds);
}

 final  List<String> _favoriteTrailIds;
@override@JsonKey(name: 'favorite_trail_ids') List<String> get favoriteTrailIds {
  if (_favoriteTrailIds is EqualUnmodifiableListView) return _favoriteTrailIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteTrailIds);
}

 final  List<FinishedTrail> _finishedTrails;
@override@JsonKey(name: 'finished_trails') List<FinishedTrail> get finishedTrails {
  if (_finishedTrails is EqualUnmodifiableListView) return _finishedTrails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_finishedTrails);
}

 final  List<Note> _notes;
@override List<Note> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}


/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&const DeepCollectionEquality().equals(other._favoritePoiIds, _favoritePoiIds)&&const DeepCollectionEquality().equals(other._favoriteTrailIds, _favoriteTrailIds)&&const DeepCollectionEquality().equals(other._finishedTrails, _finishedTrails)&&const DeepCollectionEquality().equals(other._notes, _notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isAdmin,const DeepCollectionEquality().hash(_favoritePoiIds),const DeepCollectionEquality().hash(_favoriteTrailIds),const DeepCollectionEquality().hash(_finishedTrails),const DeepCollectionEquality().hash(_notes));

@override
String toString() {
  return 'AppUser(id: $id, isAdmin: $isAdmin, favoritePoiIds: $favoritePoiIds, favoriteTrailIds: $favoriteTrailIds, finishedTrails: $finishedTrails, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'is_admin') bool isAdmin,@JsonKey(name: 'favorite_poi_ids') List<String> favoritePoiIds,@JsonKey(name: 'favorite_trail_ids') List<String> favoriteTrailIds,@JsonKey(name: 'finished_trails') List<FinishedTrail> finishedTrails, List<Note> notes
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isAdmin = null,Object? favoritePoiIds = null,Object? favoriteTrailIds = null,Object? finishedTrails = null,Object? notes = null,}) {
  return _then(_AppUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,favoritePoiIds: null == favoritePoiIds ? _self._favoritePoiIds : favoritePoiIds // ignore: cast_nullable_to_non_nullable
as List<String>,favoriteTrailIds: null == favoriteTrailIds ? _self._favoriteTrailIds : favoriteTrailIds // ignore: cast_nullable_to_non_nullable
as List<String>,finishedTrails: null == finishedTrails ? _self._finishedTrails : finishedTrails // ignore: cast_nullable_to_non_nullable
as List<FinishedTrail>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<Note>,
  ));
}


}

// dart format on
