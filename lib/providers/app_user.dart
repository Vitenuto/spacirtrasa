import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/services/app_user.dart';

part 'generated/app_user.g.dart';

@riverpod
class AppUserProvider extends _$AppUserProvider {
  final _log = Logger();

  @override
  AppUser? build() {
    ref.keepAlive();
    final userSubscription = getCurrentUserStream().listen(_onCurrentUserUpdate);
    ref.onDispose(() => userSubscription.cancel());
    return null;
  }

  void _onCurrentUserUpdate(user) {
    _log.t("AppUserProvider updated: $user");
    state = user;
  }

  Future<void> setNote(Note note) async {
    _log.t("Setting note: ${note.mapEntityId}, for user: ${state?.id}");
    if (state == null) {
      _log.w("AppUser is null, cannot set note");
      return;
    }

    // Remove the note if it already exists
    final newNotes =
        state!.notes.where((existingNote) => existingNote.mapEntityId != note.mapEntityId).toList();
    if (note.text.isNotEmpty) newNotes.add(note);

    state = state!.copyWith(notes: newNotes);
    await appUserCollection.doc(state!.id).set(state!);
  }

  void setFavoritePoi(final String poiId) {
    if (state == null) {
      _log.w("AppUser is null, cannot set favorite POI");
      return;
    }
    _log.t("Setting favorite POI: $poiId, for user: ${state?.id}");

    final newFavoritePoiIds = List<String>.from(state!.favoritePoiIds);
    if (newFavoritePoiIds.contains(poiId)) {
      newFavoritePoiIds.remove(poiId);
    } else {
      newFavoritePoiIds.add(poiId);
    }

    state = state!.copyWith(favoritePoiIds: newFavoritePoiIds);
    appUserCollection.doc(state!.id).set(state!);
  }

  void setFavoriteTrail(final String trailId) {
    if (state == null) {
      _log.w("AppUser is null, cannot set favorite Trail");
      return;
    }
    _log.t("Setting favorite Trail: $trailId, for user: ${state?.id}");

    final newFavoriteTrailIds = List<String>.from(state!.favoriteTrailIds);
    if (newFavoriteTrailIds.contains(trailId)) {
      newFavoriteTrailIds.remove(trailId);
    } else {
      newFavoriteTrailIds.add(trailId);
    }

    state = state!.copyWith(favoriteTrailIds: newFavoriteTrailIds);
    appUserCollection.doc(state!.id).set(state!);
  }

  void setFinishedTrail(Trail trail) {
    if (state == null) {
      _log.w("AppUser is null, cannot set finished trail");
      return;
    }
    if (state!.finishedTrails.any((userFinishedTrail) => userFinishedTrail.trailId == trail.id)) {
      return;
    }

    _log.i("Setting finished Trail: ${trail.id}, for user: ${state?.id}");

    final newFinishedTrail = FinishedTrail(trailId: trail.id, finishedAt: Timestamp.now());
    final newFinishedTrails = List<FinishedTrail>.from(state!.finishedTrails)
      ..add(newFinishedTrail);

    state = state!.copyWith(finishedTrails: newFinishedTrails);
    appUserCollection.doc(state!.id).set(state!);

    Fluttertoast.showToast(
      msg: 'trail-added-to-finished'.tr(args: [trail.title]),
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
