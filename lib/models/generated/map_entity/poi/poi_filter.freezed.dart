// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [PoiFilter].
extension PoiFilterPatterns on PoiFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoiFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoiFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoiFilter value)  $default,){
final _that = this;
switch (_that) {
case _PoiFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoiFilter value)?  $default,){
final _that = this;
switch (_that) {
case _PoiFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchText,  PoiFlag? flag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoiFilter() when $default != null:
return $default(_that.searchText,_that.flag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchText,  PoiFlag? flag)  $default,) {final _that = this;
switch (_that) {
case _PoiFilter():
return $default(_that.searchText,_that.flag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchText,  PoiFlag? flag)?  $default,) {final _that = this;
switch (_that) {
case _PoiFilter() when $default != null:
return $default(_that.searchText,_that.flag);case _:
  return null;

}
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
