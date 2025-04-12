// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../poi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Poi {

 String get id; String get title; String get imgUrl; String get markdownData;@GeoPointConverter() GeoPoint get location; Set<PoiFlags> get flags;@JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson) Timestamp get creationDate;
/// Create a copy of Poi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoiCopyWith<Poi> get copyWith => _$PoiCopyWithImpl<Poi>(this as Poi, _$identity);

  /// Serializes this Poi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imgUrl,markdownData,location,const DeepCollectionEquality().hash(flags),creationDate);

@override
String toString() {
  return 'Poi(id: $id, title: $title, imgUrl: $imgUrl, markdownData: $markdownData, location: $location, flags: $flags, creationDate: $creationDate)';
}


}

/// @nodoc
abstract mixin class $PoiCopyWith<$Res>  {
  factory $PoiCopyWith(Poi value, $Res Function(Poi) _then) = _$PoiCopyWithImpl;
@useResult
$Res call({
 String id, String title, String imgUrl, String markdownData,@GeoPointConverter() GeoPoint location, Set<PoiFlags> flags,@JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson) Timestamp creationDate
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imgUrl = null,Object? markdownData = null,Object? location = null,Object? flags = null,Object? creationDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imgUrl: null == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as Set<PoiFlags>,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Poi implements Poi {
  const _Poi({required this.id, required this.title, required this.imgUrl, required this.markdownData, @GeoPointConverter() required this.location, required final  Set<PoiFlags> flags, @JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson) required this.creationDate}): _flags = flags;
  factory _Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);

@override final  String id;
@override final  String title;
@override final  String imgUrl;
@override final  String markdownData;
@override@GeoPointConverter() final  GeoPoint location;
 final  Set<PoiFlags> _flags;
@override Set<PoiFlags> get flags {
  if (_flags is EqualUnmodifiableSetView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_flags);
}

@override@JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson) final  Timestamp creationDate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&(identical(other.markdownData, markdownData) || other.markdownData == markdownData)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imgUrl,markdownData,location,const DeepCollectionEquality().hash(_flags),creationDate);

@override
String toString() {
  return 'Poi(id: $id, title: $title, imgUrl: $imgUrl, markdownData: $markdownData, location: $location, flags: $flags, creationDate: $creationDate)';
}


}

/// @nodoc
abstract mixin class _$PoiCopyWith<$Res> implements $PoiCopyWith<$Res> {
  factory _$PoiCopyWith(_Poi value, $Res Function(_Poi) _then) = __$PoiCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String imgUrl, String markdownData,@GeoPointConverter() GeoPoint location, Set<PoiFlags> flags,@JsonKey(name: 'creation_date', fromJson: _dateFromJson, toJson: _dateToJson) Timestamp creationDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imgUrl = null,Object? markdownData = null,Object? location = null,Object? flags = null,Object? creationDate = null,}) {
  return _then(_Poi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imgUrl: null == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String,markdownData: null == markdownData ? _self.markdownData : markdownData // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as Set<PoiFlags>,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
