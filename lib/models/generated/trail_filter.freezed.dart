// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../trail_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrailFilter {

 (double, double) get bounds; String get searchText; List<TrailFlags> get flags;
/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrailFilterCopyWith<TrailFilter> get copyWith => _$TrailFilterCopyWithImpl<TrailFilter>(this as TrailFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrailFilter&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&const DeepCollectionEquality().equals(other.flags, flags));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,searchText,const DeepCollectionEquality().hash(flags));

@override
String toString() {
  return 'TrailFilter(bounds: $bounds, searchText: $searchText, flags: $flags)';
}


}

/// @nodoc
abstract mixin class $TrailFilterCopyWith<$Res>  {
  factory $TrailFilterCopyWith(TrailFilter value, $Res Function(TrailFilter) _then) = _$TrailFilterCopyWithImpl;
@useResult
$Res call({
 (double, double) bounds, String searchText, List<TrailFlags> flags
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
@pragma('vm:prefer-inline') @override $Res call({Object? bounds = null,Object? searchText = null,Object? flags = null,}) {
  return _then(_self.copyWith(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as (double, double),searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<TrailFlags>,
  ));
}

}


/// @nodoc


class _TrailFilter implements TrailFilter {
  const _TrailFilter({required this.bounds, required this.searchText, required final  List<TrailFlags> flags}): _flags = flags;
  

@override final  (double, double) bounds;
@override final  String searchText;
 final  List<TrailFlags> _flags;
@override List<TrailFlags> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}


/// Create a copy of TrailFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrailFilterCopyWith<_TrailFilter> get copyWith => __$TrailFilterCopyWithImpl<_TrailFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrailFilter&&(identical(other.bounds, bounds) || other.bounds == bounds)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&const DeepCollectionEquality().equals(other._flags, _flags));
}


@override
int get hashCode => Object.hash(runtimeType,bounds,searchText,const DeepCollectionEquality().hash(_flags));

@override
String toString() {
  return 'TrailFilter(bounds: $bounds, searchText: $searchText, flags: $flags)';
}


}

/// @nodoc
abstract mixin class _$TrailFilterCopyWith<$Res> implements $TrailFilterCopyWith<$Res> {
  factory _$TrailFilterCopyWith(_TrailFilter value, $Res Function(_TrailFilter) _then) = __$TrailFilterCopyWithImpl;
@override @useResult
$Res call({
 (double, double) bounds, String searchText, List<TrailFlags> flags
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
@override @pragma('vm:prefer-inline') $Res call({Object? bounds = null,Object? searchText = null,Object? flags = null,}) {
  return _then(_TrailFilter(
bounds: null == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as (double, double),searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<TrailFlags>,
  ));
}


}

// dart format on
