import 'package:spacirtrasa/models/note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/app_user.freezed.dart';
part 'generated/app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    @JsonKey(name: 'is_admin') @Default(false) bool isAdmin,
    @JsonKey(name: 'favorite_ids') required List<String> favoriteIds,
    required List<Note> notes,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
