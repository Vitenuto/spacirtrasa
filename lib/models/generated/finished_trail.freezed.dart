// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../finished_trail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinishedTrail {

 String get trailId;@JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp get finishedAt;
/// Create a copy of FinishedTrail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinishedTrailCopyWith<FinishedTrail> get copyWith => _$FinishedTrailCopyWithImpl<FinishedTrail>(this as FinishedTrail, _$identity);

  /// Serializes this FinishedTrail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinishedTrail&&(identical(other.trailId, trailId) || other.trailId == trailId)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trailId,finishedAt);

@override
String toString() {
  return 'FinishedTrail(trailId: $trailId, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class $FinishedTrailCopyWith<$Res>  {
  factory $FinishedTrailCopyWith(FinishedTrail value, $Res Function(FinishedTrail) _then) = _$FinishedTrailCopyWithImpl;
@useResult
$Res call({
 String trailId,@JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp finishedAt
});




}
/// @nodoc
class _$FinishedTrailCopyWithImpl<$Res>
    implements $FinishedTrailCopyWith<$Res> {
  _$FinishedTrailCopyWithImpl(this._self, this._then);

  final FinishedTrail _self;
  final $Res Function(FinishedTrail) _then;

/// Create a copy of FinishedTrail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trailId = null,Object? finishedAt = null,}) {
  return _then(_self.copyWith(
trailId: null == trailId ? _self.trailId : trailId // ignore: cast_nullable_to_non_nullable
as String,finishedAt: null == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FinishedTrail implements FinishedTrail {
  const _FinishedTrail({required this.trailId, @JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson) required this.finishedAt});
  factory _FinishedTrail.fromJson(Map<String, dynamic> json) => _$FinishedTrailFromJson(json);

@override final  String trailId;
@override@JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson) final  Timestamp finishedAt;

/// Create a copy of FinishedTrail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinishedTrailCopyWith<_FinishedTrail> get copyWith => __$FinishedTrailCopyWithImpl<_FinishedTrail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinishedTrailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinishedTrail&&(identical(other.trailId, trailId) || other.trailId == trailId)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trailId,finishedAt);

@override
String toString() {
  return 'FinishedTrail(trailId: $trailId, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class _$FinishedTrailCopyWith<$Res> implements $FinishedTrailCopyWith<$Res> {
  factory _$FinishedTrailCopyWith(_FinishedTrail value, $Res Function(_FinishedTrail) _then) = __$FinishedTrailCopyWithImpl;
@override @useResult
$Res call({
 String trailId,@JsonKey(name: 'finished_at', fromJson: dateFromJson, toJson: dateToJson) Timestamp finishedAt
});




}
/// @nodoc
class __$FinishedTrailCopyWithImpl<$Res>
    implements _$FinishedTrailCopyWith<$Res> {
  __$FinishedTrailCopyWithImpl(this._self, this._then);

  final _FinishedTrail _self;
  final $Res Function(_FinishedTrail) _then;

/// Create a copy of FinishedTrail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trailId = null,Object? finishedAt = null,}) {
  return _then(_FinishedTrail(
trailId: null == trailId ? _self.trailId : trailId // ignore: cast_nullable_to_non_nullable
as String,finishedAt: null == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
