import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/note.dart';
import 'app_user.dart';

part 'generated/note.g.dart';

@riverpod
class NoteProvider extends _$NoteProvider {
  static final log = Logger();

  @override
  List<Note> build() {
    log.t("Building Note provider...");
    final appUser = ref.watch(appUserProvider);
    if (appUser == null) return List.empty();

    return appUser.notes;
  }
}
