import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/services/user/app_user_service.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/utils/utils.dart';

const usersCollectionId = 'USERS';
final _firestore = FirebaseFirestore.instance;

final appUserCollection = _firestore
    .collection(usersCollectionId)
    .withConverter(
      fromFirestore: FirestoreConverters.fromFirestore<AppUser>(AppUser.fromJson),
      toFirestore: FirestoreConverters.toFirestore(),
    );

Future<Stream<AppUser?>> mapFirebaseUserToAppUserStream(User? firebaseUser) async {
  if (firebaseUser == null) return Stream.value(null);

  return appUserCollection
      .doc(firebaseUser.uid)
      .snapshots()
      .map((appUserSnapshot) => appUserSnapshot.data())
      .where((data) => data != null);
}

Future<void> createAppUserIfNeeded(String userId) async {
  final appUser = (await appUserCollection.doc(userId).get()).data();
  if (appUser == null) {
    final newUser = getEmptyAppUser(id: userId);
    await setUser(newUser);
    logger.t("New user is successfully created: $newUser");
  }
}

Future<void> setUser(AppUser newAppUser) async {
  await appUserCollection.doc(newAppUser.id).set(newAppUser);
}
