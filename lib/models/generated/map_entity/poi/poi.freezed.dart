// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../map_entity/poi/poi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Poi {

 String get id; String get title; String get imgUrl; String get markdownData;@GeoPointConverter() GeoPoint get location; PoiFlag get flag;@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp get createdAt;
/// Create a copy of Poi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoiCopyWith<Poi> get copyWith => _$PoiCopyWithImpl<Poi>(this as Poi, _$identity);

  /// Serializes this Poi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&(identical(other.location, location) || other.location == location)&&(identical(other.flag, flag) || other.flag == flag)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imgUrl,markdownData,location,flag,createdAt);

@override
String toString() {
  return 'Poi(id: $id, title: $title, imgUrl: $imgUrl, markdownData: $markdownData, location: $location, flag: $flag, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PoiCopyWith<$Res>  {
  factory $PoiCopyWith(Poi value, $Res Function(Poi) _then) = _$PoiCopyWithImpl;
@useResult
$Res call({
 String id, String title, String imgUrl, String markdownData,@GeoPointConverter() GeoPoint location, PoiFlag flag,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
});




}
/// @nodoc
class _$PoiCopyWithImpl<$Res>
    implements $PoiCopyWith<$Res> {
  _$PoiCopyWithImpl(this._self, this._then);

  final Poi _self;
  final $Res Function(Poi) _then;

/// Create a copy of Poi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imgUrl = null,Object? markdownData = null,Object? location = null,Object? flag = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imgUrl: null == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as PoiFlag,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [Poi].
extension PoiPatterns on Poi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Poi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Poi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Poi value)  $default,){
final _that = this;
switch (_that) {
case _Poi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Poi value)?  $default,){
final _that = this;
switch (_that) {
case _Poi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String imgUrl,  String markdownData, @GeoPointConverter()  GeoPoint location,  PoiFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Poi() when $default != null:
return $default(_that.id,_that.title,_that.imgUrl,_that.markdownData,_that.location,_that.flag,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String imgUrl,  String markdownData, @GeoPointConverter()  GeoPoint location,  PoiFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)  $default,) {final _that = this;
switch (_that) {
case _Poi():
return $default(_that.id,_that.title,_that.imgUrl,_that.markdownData,_that.location,_that.flag,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String imgUrl,  String markdownData, @GeoPointConverter()  GeoPoint location,  PoiFlag flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson)  Timestamp createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Poi() when $default != null:
return $default(_that.id,_that.title,_that.imgUrl,_that.markdownData,_that.location,_that.flag,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Poi extends Poi {
   _Poi({required this.id, required this.title, required this.imgUrl, required this.markdownData, @GeoPointConverter() required this.location, required this.flag, @JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) required this.createdAt}): super._();
  factory _Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);

@override final  String id;
@override final  String title;
@override final  String imgUrl;
@override final  String markdownData;
@override@GeoPointConverter() final  GeoPoint location;
@override final  PoiFlag flag;
@override@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) final  Timestamp createdAt;

/// Create a copy of Poi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoiCopyWith<_Poi> get copyWith => __$PoiCopyWithImpl<_Poi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&(identical(other.location, location) || other.location == location)&&(identical(other.flag, flag) || other.flag == flag)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imgUrl,markdownData,location,flag,createdAt);

@override
String toString() {
  return 'Poi(id: $id, title: $title, imgUrl: $imgUrl, markdownData: $markdownData, location: $location, flag: $flag, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PoiCopyWith<$Res> implements $PoiCopyWith<$Res> {
  factory _$PoiCopyWith(_Poi value, $Res Function(_Poi) _then) = __$PoiCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String imgUrl, String markdownData,@GeoPointConverter() GeoPoint location, PoiFlag flag,@JsonKey(name: 'created_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp createdAt
});




}
/// @nodoc
class __$PoiCopyWithImpl<$Res>
    implements _$PoiCopyWith<$Res> {
  __$PoiCopyWithImpl(this._self, this._then);

  final _Poi _self;
  final $Res Function(_Poi) _then;

/// Create a copy of Poi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imgUrl = null,Object? markdownData = null,Object? location = null,Object? flag = null,Object? createdAt = null,}) {
  return _then(_Poi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imgUrl: null == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as PoiFlag,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
