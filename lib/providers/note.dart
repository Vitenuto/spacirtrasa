import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';

part 'generated/note.g.dart';

@riverpod
class NoteProvider extends _$NoteProvider {
  static final _log = Logger();

  @override
  List<Note> build() {
    _log.t("Building Note provider...");
    final appUser = ref.watch(appUserProvider);
    return appUser.notes;
  }
}
