// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../map_entity/trail/trail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Trail {

 String get id; String get title; String get markdownData;@GeoPointConverter() List<GeoPoint> get path; Set<TrailFlags> get flags;@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp get createdAt;
/// Create a copy of Trail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrailCopyWith<Trail> get copyWith => _$TrailCopyWithImpl<Trail>(this as Trail, _$identity);

  /// Serializes this Trail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&const DeepCollectionEquality().equals(other.path, path)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,markdownData,const DeepCollectionEquality().hash(path),const DeepCollectionEquality().hash(flags),createdAt);

@override
String toString() {
  return 'Trail(id: $id, title: $title, markdownData: $markdownData, path: $path, flags: $flags, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TrailCopyWith<$Res>  {
  factory $TrailCopyWith(Trail value, $Res Function(Trail) _then) = _$TrailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String markdownData,@GeoPointConverter() List<GeoPoint> path, Set<TrailFlags> flags,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
});




}
/// @nodoc
class _$TrailCopyWithImpl<$Res>
    implements $TrailCopyWith<$Res> {
  _$TrailCopyWithImpl(this._self, this._then);

  final Trail _self;
  final $Res Function(Trail) _then;

/// Create a copy of Trail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? markdownData = null,Object? path = null,Object? flags = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as Set<TrailFlags>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Trail extends Trail {
   _Trail({required this.id, required this.title, required this.markdownData, @GeoPointConverter() required final  List<GeoPoint> path, required final  Set<TrailFlags> flags, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) required this.createdAt}): _path = path,_flags = flags,super._();
  factory _Trail.fromJson(Map<String, dynamic> json) => _$TrailFromJson(json);

@override final  String id;
@override final  String title;
@override final  String markdownData;
 final  List<GeoPoint> _path;
@override@GeoPointConverter() List<GeoPoint> get path {
  if (_path is EqualUnmodifiableListView) return _path;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_path);
}

 final  Set<TrailFlags> _flags;
@override Set<TrailFlags> get flags {
  if (_flags is EqualUnmodifiableSetView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_flags);
}

@override@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) final  Timestamp createdAt;

/// Create a copy of Trail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrailCopyWith<_Trail> get copyWith => __$TrailCopyWithImpl<_Trail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&const DeepCollectionEquality().equals(other._path, _path)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,markdownData,const DeepCollectionEquality().hash(_path),const DeepCollectionEquality().hash(_flags),createdAt);

@override
String toString() {
  return 'Trail(id: $id, title: $title, markdownData: $markdownData, path: $path, flags: $flags, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TrailCopyWith<$Res> implements $TrailCopyWith<$Res> {
  factory _$TrailCopyWith(_Trail value, $Res Function(_Trail) _then) = __$TrailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String markdownData,@GeoPointConverter() List<GeoPoint> path, Set<TrailFlags> flags,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
});




}
/// @nodoc
class __$TrailCopyWithImpl<$Res>
    implements _$TrailCopyWith<$Res> {
  __$TrailCopyWithImpl(this._self, this._then);

  final _Trail _self;
  final $Res Function(_Trail) _then;

/// Create a copy of Trail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? markdownData = null,Object? path = null,Object? flags = null,Object? createdAt = null,}) {
  return _then(_Trail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self._path : path // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as Set<TrailFlags>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
