import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/user/firebase_app_user.dart';
import 'package:spacirtrasa/providers/user/local_app_user.dart';
import 'package:spacirtrasa/services/user/app_user_service.dart' as appUserService;
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart' as firebaseAppUserService;
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/user/app_user.g.dart';

/// AppUser provider that listens to both Firebase and local user providers.
/// If Firebase user is available, it takes precedence over the local user, however
/// at the beginning, automatically the local user is used until a Firebase user is available.
@Riverpod(keepAlive: true)
class AppUserProvider extends _$AppUserProvider {
  bool _isLocal = true;

  @override
  AppUser build() {
    logger.t("Building AppUser provider...");
    _prepareFirebaseAppUserSubscription();
    _prepareLocalAppUserSubscription();
    return appUserService.getEmptyAppUser();
  }

  void _prepareFirebaseAppUserSubscription() {
    final firebaseAppUserSubscription = ref.listen(
      firebaseAppUserProvider,
      (_, firebaseAppUserNew) => _onFirebaseAppUserUpdate(firebaseAppUserNew),
    );
    ref.onDispose(() => firebaseAppUserSubscription.close());
  }

  void _prepareLocalAppUserSubscription() async {
    final localAppUserSubscription = ref.listen(localUserProvider, (_, next) {
      if (_isLocal && next.value != null) {
        final localUserNew = next.value!;
        state = localUserNew;
      }
    });
    ref.onDispose(() => localAppUserSubscription.close());
  }

  /// If the firebase user is null, switch to local user.
  void _onFirebaseAppUserUpdate(AppUser? user) async {
    if (user == null) {
      _isLocal = true;
      state = await ref.read(localUserProvider.future);
      logger.t("Got null user from Firebase, switching to local user: $state");
      return;
    }
    _isLocal = false;
    logger.t("Got firebase user update: $user");
    state = user;
  }

  Future<void> setNote(Note note) async {
    logger.t("Setting note: ${note.mapEntityId}, for user: ${state.id}");
    await setUser(await appUserService.setNote(state, note));
  }

  Future<void> setFavoritePoi(String poiId) async {
    logger.t("Setting favorite POI: $poiId, for user: ${state.id}");
    await setUser(await appUserService.setFavoritePoi(state, poiId));
  }

  Future<void> setFavoriteTrail(String trailId) async {
    logger.t("Setting favorite Trail: $trailId, for user: ${state.id}");
    await setUser(await appUserService.setFavoriteTrail(state, trailId));
  }

  Future<void> setFinishedTrail(Trail trail) async {
    logger.i("Setting finished Trail: ${trail.id}, for user: ${state.id}");
    await setUser(await appUserService.setFinishedTrail(state, trail.id));
    Fluttertoast.showToast(
      msg: 'trail-added-to-finished'.tr(args: [trail.title]),
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Future<void> setUser(AppUser newAppUser) async {
    if (_isLocal) {
      return ref.read(localUserProvider.notifier).setUser(newAppUser);
    }
    return firebaseAppUserService.setUser(newAppUser);
  }
}
