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
  final Stream<AppUser?> stream = _firebaseAuth.authStateChanges().switchMap((authUser) {
    _log.t("Updating currentUserStream because authUser changed to: $authUser");
    if (authUser == null || authUser.isAnonymous) return Stream.value(null);

    return appUserCollection
        .doc(authUser.uid)
        .snapshots()
        .map((appUserSnapshot) => appUserSnapshot.data())
        .whereNotNull();
  });
  return stream;
}

Future<void> createAppUserIfNeeded(final String userId) async {
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
