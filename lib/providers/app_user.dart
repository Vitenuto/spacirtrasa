import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/services/app_user.dart';

part 'generated/app_user.g.dart';

@riverpod
class AppUserProvider extends _$AppUserProvider {
  final log = Logger();

  @override
  AppUser? build() {
    ref.keepAlive();
    final userSubscription = getCurrentUserStream().listen((user) => state = user);
    ref.onDispose(() => userSubscription.cancel());
    return null;
  }

  void setNote(Note note) {
    log.t("Setting note: ${note.mapEntityId}, for user: ${state?.id}");
    if (state == null) {
      log.w("AppUser is null, cannot set note");
      return;
    }

    // Remove the note if it already exists
    final newNotes =
        state!.notes.where((existingNote) => existingNote.mapEntityId != note.mapEntityId).toList();
    newNotes.add(note);

    state = state!.copyWith(notes: newNotes);

    appUserCollection
        .doc(state!.id)
        .update(state!.toJson());
  }

  void setFavoritePoi(final String poiId) {
    log.t("Setting favorite POI: $poiId, for user: ${state?.id}");
    if (state == null) {
      log.w("AppUser is null, cannot set favorite POI");
      return;
    }

    final newFavoritePoiIds = List<String>.from(state!.favoritePoiIds);
    if (newFavoritePoiIds.contains(poiId)) {
      newFavoritePoiIds.remove(poiId);
    } else {
      newFavoritePoiIds.add(poiId);
    }

    state = state!.copyWith(favoritePoiIds: newFavoritePoiIds);

    appUserCollection
        .doc(state!.id)
        .update(state!.toJson());
  }
}
