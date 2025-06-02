import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/providers/app_user.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/services/map_entity/position.dart';
import 'package:spacirtrasa/utils/constants.dart';

part '../generated/map_entity/position.g.dart';

@riverpod
class PositionProvider extends _$PositionProvider {
  static final log = Logger();
  StreamSubscription<Position>? positionSubscription;

  @override
  Position? build() {
    final serviceStatus = ref.watch(positionPermissionStatusProvider);
    if (serviceStatus == ServiceStatus.disabled) {
      log.w("ServiceStatus is $serviceStatus, canceling position");
      positionSubscription?.cancel();
      return null;
    }

    log.t("Building Position provider...");
    _init();
    return null;
  }

  void _init() async {
    if (await PositionService.checkPermissions() == false) return;
    positionSubscription = PositionService.getPositionStream().listen(_onPosition);
    ref.onDispose(() => positionSubscription?.cancel());
  }

  void _onPosition(Position position) {
    if (position.isNotEqual(state)) {
      log.t("New position: $position");
      state = position;

      _checkIsFinishedTrail(position);
    }
  }

  void _checkIsFinishedTrail(final Position position) {
    final trail = ref.read(pinnedTrailProvider);
    if (trail == null) return;

    final distance = trail.getDistanceFromLocation(position);
    if (distance != null && distance < userFromTrailThresholdMeters) {
      ref.read(appUserProvider.notifier).setFinishedTrail(trail);
    }
  }
}
