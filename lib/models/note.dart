import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/note.freezed.dart';
part 'generated/note.g.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    required String text,
    @JsonKey(name: "owner_id") required String ownerId,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
