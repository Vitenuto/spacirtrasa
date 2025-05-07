import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';

part 'generated/note.freezed.dart';
part 'generated/note.g.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    @JsonKey(name: "map_entity_id") required String mapEntityId,
    required String text,
    required MapEntityType type,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
