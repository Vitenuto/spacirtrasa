import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/models/note.dart';

final String localUserId = 'local_user_id';

Future<AppUser> setNote(AppUser appUser, Note note) async {
  final newNotes =
      appUser.notes.where((existingNote) => existingNote.mapEntityId != note.mapEntityId).toList();
  if (note.text.isNotEmpty) newNotes.add(note);

  return appUser.copyWith(notes: newNotes);
}

Future<AppUser> setFavoritePoi(AppUser appUser, String poiId) async {
  final newFavoritePoiIds = List<String>.from(appUser.favoritePoiIds);
  if (newFavoritePoiIds.contains(poiId)) {
    newFavoritePoiIds.remove(poiId);
  } else {
    newFavoritePoiIds.add(poiId);
  }

  return appUser.copyWith(favoritePoiIds: newFavoritePoiIds);
}

Future<AppUser> setFavoriteTrail(AppUser appUser, String trailId) async {
  final newFavoriteTrailIds = List<String>.from(appUser.favoriteTrailIds);
  if (newFavoriteTrailIds.contains(trailId)) {
    newFavoriteTrailIds.remove(trailId);
  } else {
    newFavoriteTrailIds.add(trailId);
  }

  return appUser.copyWith(favoriteTrailIds: newFavoriteTrailIds);
}

Future<AppUser> setFinishedTrail(AppUser appUser, String trailId) async {
  if (appUser.finishedTrails.any((userFinishedTrail) => userFinishedTrail.trailId == trailId)) {
    return appUser;
  }
  final newFinishedTrail = FinishedTrail(trailId: trailId, finishedAt: Timestamp.now());
  final newFinishedTrails = List<FinishedTrail>.from(appUser.finishedTrails)..add(newFinishedTrail);

  return appUser.copyWith(finishedTrails: newFinishedTrails);
}

AppUser getEmptyAppUser({String? id}) => AppUser(
  id: id ?? localUserId,
  isAdmin: false,
  favoritePoiIds: [],
  favoriteTrailIds: [],
  finishedTrails: [],
  notes: [],
);
