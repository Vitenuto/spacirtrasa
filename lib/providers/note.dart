import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';
import 'package:spacirtrasa/utils/utils.dart';

part 'generated/note.g.dart';

@riverpod
class NoteProvider extends _$NoteProvider {
  @override
  List<Note> build() {
    logger.t("Building Note provider...");
    final appUser = ref.watch(appUserProvider);
    return appUser.notes;
  }
}
