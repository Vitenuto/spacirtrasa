import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/finished_trail.dart';
import 'package:spacirtrasa/models/note.dart';

part 'generated/app_user.freezed.dart';
part 'generated/app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    @JsonKey(name: 'is_admin') @Default(false) bool isAdmin,
    @JsonKey(name: 'favorite_poi_ids') required List<String> favoritePoiIds,
    @JsonKey(name: 'favorite_trail_ids') required List<String> favoriteTrailIds,
    @JsonKey(name: 'finished_trails') required List<FinishedTrail> finishedTrails,
    required List<Note> notes,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
