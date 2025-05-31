// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../map_entity/trail/trail_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrailFilter {

 (double, double) get bounds; String get searchText; TrailFlag? get flag;
/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrailFilterCopyWith<TrailFilter> get copyWith => _$TrailFilterCopyWithImpl<TrailFilter>(this as TrailFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrailFilter&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.flag, flag) || other.flag == flag));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,searchText,flag);

@override
String toString() {
  return 'TrailFilter(bounds: $bounds, searchText: $searchText, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $TrailFilterCopyWith<$Res>  {
  factory $TrailFilterCopyWith(TrailFilter value, $Res Function(TrailFilter) _then) = _$TrailFilterCopyWithImpl;
@useResult
$Res call({
 (double, double) bounds, String searchText, TrailFlag? flag
});




}
/// @nodoc
class _$TrailFilterCopyWithImpl<$Res>
    implements $TrailFilterCopyWith<$Res> {
  _$TrailFilterCopyWithImpl(this._self, this._then);

  final TrailFilter _self;
  final $Res Function(TrailFilter) _then;

/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bounds = null,Object? searchText = null,Object? flag = freezed,}) {
  return _then(_self.copyWith(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as (double, double),searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as TrailFlag?,
  ));
}

}


/// @nodoc


class _TrailFilter implements TrailFilter {
  const _TrailFilter({required this.bounds, required this.searchText, required this.flag});
  

@override final  (double, double) bounds;
@override final  String searchText;
@override final  TrailFlag? flag;

/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrailFilterCopyWith<_TrailFilter> get copyWith => __$TrailFilterCopyWithImpl<_TrailFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrailFilter&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.flag, flag) || other.flag == flag));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,searchText,flag);

@override
String toString() {
  return 'TrailFilter(bounds: $bounds, searchText: $searchText, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$TrailFilterCopyWith<$Res> implements $TrailFilterCopyWith<$Res> {
  factory _$TrailFilterCopyWith(_TrailFilter value, $Res Function(_TrailFilter) _then) = __$TrailFilterCopyWithImpl;
@override @useResult
$Res call({
 (double, double) bounds, String searchText, TrailFlag? flag
});




}
/// @nodoc
class __$TrailFilterCopyWithImpl<$Res>
    implements _$TrailFilterCopyWith<$Res> {
  __$TrailFilterCopyWithImpl(this._self, this._then);

  final _TrailFilter _self;
  final $Res Function(_TrailFilter) _then;

/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bounds = null,Object? searchText = null,Object? flag = freezed,}) {
  return _then(_TrailFilter(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as (double, double),searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as TrailFlag?,
  ));
}


}

// dart format on
