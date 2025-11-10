// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 String get id; String get title; String get markdownData;@GeoPointConverter() List<GeoPoint> get path; TrailFlag get flag;@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp get createdAt;
/// Create a copy of Trail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrailCopyWith<Trail> get copyWith => _$TrailCopyWithImpl<Trail>(this as Trail, _$identity);

  /// Serializes this Trail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&const DeepCollectionEquality().equals(other.path, path)&&(identical(other.flag, flag) || other.flag == flag)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,markdownData,const DeepCollectionEquality().hash(path),flag,createdAt);

@override
String toString() {
  return 'Trail(id: $id, title: $title, markdownData: $markdownData, path: $path, flag: $flag, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TrailCopyWith<$Res>  {
  factory $TrailCopyWith(Trail value, $Res Function(Trail) _then) = _$TrailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String markdownData,@GeoPointConverter() List<GeoPoint> path, TrailFlag flag,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? markdownData = null,Object? path = null,Object? flag = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as TrailFlag,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [Trail].
extension TrailPatterns on Trail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trail value)  $default,){
final _that = this;
switch (_that) {
case _Trail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trail value)?  $default,){
final _that = this;
switch (_that) {
case _Trail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String markdownData, @GeoPointConverter()  List<GeoPoint> path,  TrailFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trail() when $default != null:
return $default(_that.id,_that.title,_that.markdownData,_that.path,_that.flag,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String markdownData, @GeoPointConverter()  List<GeoPoint> path,  TrailFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)  $default,) {final _that = this;
switch (_that) {
case _Trail():
return $default(_that.id,_that.title,_that.markdownData,_that.path,_that.flag,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String markdownData, @GeoPointConverter()  List<GeoPoint> path,  TrailFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Trail() when $default != null:
return $default(_that.id,_that.title,_that.markdownData,_that.path,_that.flag,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trail extends Trail {
   _Trail({required this.id, required this.title, required this.markdownData, @GeoPointConverter() required final  List<GeoPoint> path, required this.flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) required this.createdAt}): _path = path,super._();
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

@override final  TrailFlag flag;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&const DeepCollectionEquality().equals(other._path, _path)&&(identical(other.flag, flag) || other.flag == flag)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,markdownData,const DeepCollectionEquality().hash(_path),flag,createdAt);

@override
String toString() {
  return 'Trail(id: $id, title: $title, markdownData: $markdownData, path: $path, flag: $flag, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TrailCopyWith<$Res> implements $TrailCopyWith<$Res> {
  factory _$TrailCopyWith(_Trail value, $Res Function(_Trail) _then) = __$TrailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String markdownData,@GeoPointConverter() List<GeoPoint> path, TrailFlag flag,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? markdownData = null,Object? path = null,Object? flag = null,Object? createdAt = null,}) {
  return _then(_Trail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self._path : path // ignore: cast_nullable_to_non_nullable
as List<GeoPoint>,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as TrailFlag,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
