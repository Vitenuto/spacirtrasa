import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../models/app_user.dart';
import '../services/utils/converters.dart';

part 'generated/app_user.g.dart';

@riverpod
class AppUserProvider extends _$AppUserProvider {
  final log = Logger();
  static const usersCollectionId = 'USERS';
  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static final appUserCollection = _firebaseFirestore
      .collection(usersCollectionId)
      .withConverter(
        fromFirestore: FirestoreConverters.fromFirestore<AppUser>(AppUser.fromJson),
        toFirestore: FirestoreConverters.toFirestore(),
      );

  @override
  AppUser? build() {
    final userSubscription = _getCurrentUserStream().listen((user) => state = user);
    ref.onDispose(() => userSubscription.cancel());
    return null;
  }

  Stream<AppUser?> _getCurrentUserStream() {
    final Stream<AppUser?> stream = _firebaseAuth.authStateChanges().switchMap((authUser) {
      log.t("Updating currentUserStream because authUser changed to: $authUser");
      if (authUser == null || authUser.isAnonymous) return Stream.value(null);

      return appUserCollection
          .doc(authUser.uid)
          .snapshots()
          .map((appUserSnapshot) => appUserSnapshot.data())
          .whereNotNull();
    });
    return stream;
  }
}
