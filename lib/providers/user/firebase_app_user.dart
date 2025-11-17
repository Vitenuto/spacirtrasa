import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/providers/user/firebase_user.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/user/firebase_app_user.g.dart';

@riverpod
class FirebaseAppUserProvider extends _$FirebaseAppUserProvider {
  @override
  AppUser? build() {
    logger.t("Building FirebaseUser provider...");
    final firebaseUser = ref.watch(firebaseUserProvider);
    _setUpFirebaseListener(firebaseUser);
    return null;
  }

  /// Creating and listening to AppUser stream (from firestore DB) based on the current firebaseUser.
  Future<void> _setUpFirebaseListener(User? firebaseUser) async {
    final firebaseAppUserStream = await mapFirebaseUserToAppUserStream(firebaseUser);
    final firebaseAppUserListener = firebaseAppUserStream.listen((appUser) {
      logger.i("Firebase AppUser updated: $appUser");
      state = appUser;
    });
    ref.onDispose(() => firebaseAppUserListener.cancel());
  }
}
