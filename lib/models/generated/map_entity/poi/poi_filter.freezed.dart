// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../map_entity/poi/poi_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PoiFilter {

 String get searchText; PoiFlag? get flag;
/// Create a copy of PoiFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoiFilterCopyWith<PoiFilter> get copyWith => _$PoiFilterCopyWithImpl<PoiFilter>(this as PoiFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoiFilter&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.flag, flag) || other.flag == flag));
}


@override
int get hashCode => Object.hash(runtimeType,searchText,flag);

@override
String toString() {
  return 'PoiFilter(searchText: $searchText, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $PoiFilterCopyWith<$Res>  {
  factory $PoiFilterCopyWith(PoiFilter value, $Res Function(PoiFilter) _then) = _$PoiFilterCopyWithImpl;
@useResult
$Res call({
 String searchText, PoiFlag? flag
});




}
/// @nodoc
class _$PoiFilterCopyWithImpl<$Res>
    implements $PoiFilterCopyWith<$Res> {
  _$PoiFilterCopyWithImpl(this._self, this._then);

  final PoiFilter _self;
  final $Res Function(PoiFilter) _then;

/// Create a copy of PoiFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchText = null,Object? flag = freezed,}) {
  return _then(_self.copyWith(
searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as PoiFlag?,
  ));
}

}


/// @nodoc


class _PoiFilter implements PoiFilter {
  const _PoiFilter({required this.searchText, required this.flag});
  

@override final  String searchText;
@override final  PoiFlag? flag;

/// Create a copy of PoiFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoiFilterCopyWith<_PoiFilter> get copyWith => __$PoiFilterCopyWithImpl<_PoiFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoiFilter&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.flag, flag) || other.flag == flag));
}


@override
int get hashCode => Object.hash(runtimeType,searchText,flag);

@override
String toString() {
  return 'PoiFilter(searchText: $searchText, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$PoiFilterCopyWith<$Res> implements $PoiFilterCopyWith<$Res> {
  factory _$PoiFilterCopyWith(_PoiFilter value, $Res Function(_PoiFilter) _then) = __$PoiFilterCopyWithImpl;
@override @useResult
$Res call({
 String searchText, PoiFlag? flag
});




}
/// @nodoc
class __$PoiFilterCopyWithImpl<$Res>
    implements _$PoiFilterCopyWith<$Res> {
  __$PoiFilterCopyWithImpl(this._self, this._then);

  final _PoiFilter _self;
  final $Res Function(_PoiFilter) _then;

/// Create a copy of PoiFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchText = null,Object? flag = freezed,}) {
  return _then(_PoiFilter(
searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as PoiFlag?,
  ));
}


}

// dart format on
