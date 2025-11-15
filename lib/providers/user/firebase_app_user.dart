import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/providers/user/firebase_user.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';

part '../generated/user/firebase_app_user.g.dart';

@riverpod
class FirebaseAppUserProvider extends _$FirebaseAppUserProvider {
  final _log = Logger();

  @override
  AppUser? build() {
    _log.t("Building FirebaseUser provider...");
    final firebaseUser = ref.watch(firebaseUserProvider);
    _setUpFirebaseListener(firebaseUser);
    return null;
  }

  /// Creating and listening to AppUser stream (from firestore DB) based on the current firebaseUser.
  Future<void> _setUpFirebaseListener(User? firebaseUser) async {
    final firebaseAppUserStream = await mapFirebaseUserToAppUserStream(firebaseUser);
    final firebaseAppUserListener = firebaseAppUserStream.listen((appUser) {
      _log.i("Firebase AppUser updated: $appUser");
      state = appUser;
    });
    ref.onDispose(() => firebaseAppUserListener.cancel());
  }
}
