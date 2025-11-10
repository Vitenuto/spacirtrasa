import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/user/local_app_user.dart';
import 'package:spacirtrasa/services/user/app_user_service.dart' as appUserService;
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart' as firebaseAppUserService;

part '../generated/user/app_user.g.dart';

@Riverpod(keepAlive: true)
class AppUserProvider extends _$AppUserProvider {
  final _log = Logger();
  bool _isLocal = true;
  late final ProviderSubscription _localAppUserSubscription;
  late final StreamSubscription _firebaseAppUserSubscription;

  @override
  AppUser build() {
    _prepareFirebaseAppUserSubscription();
    _prepareLocalAppUserSubscription();
    return appUserService.emptyAppUser;
  }

  void _prepareFirebaseAppUserSubscription() {
    _firebaseAppUserSubscription = firebaseAppUserService.getCurrentUserStream().listen(
      _onFirebaseAppUserUpdate,
    );
    ref.onDispose(() => _firebaseAppUserSubscription.cancel());
  }

  void _prepareLocalAppUserSubscription() async {
    _localAppUserSubscription = ref.listen(localUserProvider, (previous, next) {
      if (_isLocal && next.value != null) {
        final localUserNew = next.value!;
        state = localUserNew;
      }
    });
    ref.onDispose(() => _localAppUserSubscription.close());
  }

  void _onFirebaseAppUserUpdate(AppUser? user) async {
    if (user == null) {
      _isLocal = true;
      state = await ref.read(localUserProvider.future);
      _log.t("Got null user from Firebase, switching to local user: $state");
      return;
    }
    _isLocal = false;
    _log.t("Got firebase user update: $user");
    state = user;
  }

  Future<void> setNote(Note note) async {
    _log.t("Setting note: ${note.mapEntityId}, for user: ${state.id}");
    await setUser(await appUserService.setNote(state, note));
  }

  Future<void> setFavoritePoi(String poiId) async {
    _log.t("Setting favorite POI: $poiId, for user: ${state.id}");
    await setUser(await appUserService.setFavoritePoi(state, poiId));
  }

  Future<void> setFavoriteTrail(String trailId) async {
    _log.t("Setting favorite Trail: $trailId, for user: ${state.id}");
    await setUser(await appUserService.setFavoriteTrail(state, trailId));
  }

  Future<void> setFinishedTrail(Trail trail) async {
    _log.i("Setting finished Trail: ${trail.id}, for user: ${state.id}");
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
