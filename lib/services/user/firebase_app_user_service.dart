import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/utils/converters.dart';

const usersCollectionId = 'USERS';
final _firebaseAuth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _log = Logger();

final appUserCollection = _firestore
    .collection(usersCollectionId)
    .withConverter(
      fromFirestore: FirestoreConverters.fromFirestore<AppUser>(AppUser.fromJson),
      toFirestore: FirestoreConverters.toFirestore(),
    );

Stream<AppUser?> getCurrentUserStream() {
  return _firebaseAuth.authStateChanges().switchMap(mapAuthUserToAppUser);
}

Stream<AppUser?> mapAuthUserToAppUser(User? authUser) {
  if (authUser == null || authUser.isAnonymous) return Stream.value(null);

  return appUserCollection
      .doc(authUser.uid)
      .snapshots()
      .map((appUserSnapshot) => appUserSnapshot.data())
      .whereNotNull();
}

Future<void> createAppUserIfNeeded(String userId) async {
  final appUser = (await appUserCollection.doc(userId).get()).data();
  if (appUser == null) {
    final newUser = AppUser(
      id: userId,
      isAdmin: false,
      favoritePoiIds: [],
      favoriteTrailIds: [],
      finishedTrails: [],
      notes: [],
    );
    await appUserCollection.doc(userId).set(newUser);
    _log.t("New user '$newUser' is successfully created");
  }
}

@override
Future<void> setUser(AppUser newAppUser) async {
  await appUserCollection.doc(newAppUser.id).set(newAppUser);
}
